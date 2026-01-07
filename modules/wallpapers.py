"""
Wallpaper selector module for SyndraShell
Manages wallpaper selection and theme generation
"""
import os
import hashlib
import random
import concurrent.futures
from concurrent.futures import ThreadPoolExecutor
from PIL import Image

from fabric.utils import exec_shell_command_async
from fabric.widgets.box import Box
from fabric.widgets.button import Button
from fabric.widgets.entry import Entry
from fabric.widgets.label import Label
from fabric.widgets.scrolledwindow import ScrolledWindow
from gi.repository import Gdk, GdkPixbuf, Gio, GLib, Gtk

import config.data as data
import modules.icons as icons


class WallpaperSelector(Box):
    """Wallpaper selector with thumbnail preview"""
    
    CACHE_DIR = f"{data.CACHE_DIR}/thumbs"
    
    def __init__(self, **kwargs):
        super().__init__(
            name="wallpapers",
            spacing=4,
            orientation="v",
            h_expand=True,
            v_expand=True,
            **kwargs,
        )
        
        os.makedirs(self.CACHE_DIR, exist_ok=True)
        os.makedirs(data.get_default("wallpapers_dir", "~/Pictures/Wallpapers"), exist_ok=True)
        
        self.files = []
        self.thumbnails = []
        self.thumbnail_queue = []
        self.executor = ThreadPoolExecutor(max_workers=4)
        self.selected_index = -1
        
        # IconView for wallpapers
        self.viewport = Gtk.IconView(name="wallpaper-icons")
        self.viewport.set_model(Gtk.ListStore(GdkPixbuf.Pixbuf, str))
        self.viewport.set_pixbuf_column(0)
        self.viewport.set_text_column(-1)
        self.viewport.set_item_width(0)
        self.viewport.connect("item-activated", self.on_wallpaper_selected)
        
        # Scrolled window
        self.scrolled_window = ScrolledWindow(
            name="wallpaper-scrolled",
            h_expand=True,
            v_expand=True,
            child=self.viewport,
        )
        
        # Search entry
        self.search_entry = Entry(
            name="search-wallpapers",
            placeholder="Search wallpapers...",
            h_expand=True,
            notify_text=lambda entry, *_: self.arrange_viewport(entry.get_text()),
        )
        
        # Random button
        self.random_btn = Button(
            name="random-wallpaper",
            label="🎲 Random",
            on_clicked=self.set_random_wallpaper,
        )
        
        # Controls box
        controls = Box(
            orientation="h",
            spacing=8,
            children=[
                self.search_entry,
                self.random_btn,
            ],
        )
        
        self.children = [controls, self.scrolled_window]
        
        # Load wallpapers
        GLib.idle_add(self._load_wallpapers_async().__next__)
        self.setup_file_monitor()
    
    def _load_wallpapers_async(self):
        """Load wallpapers asynchronously"""
        wallpapers_dir = os.path.expanduser(data.get_default("wallpapers_dir", "~/Pictures/Wallpapers"))
        
        if not os.path.exists(wallpapers_dir):
            yield False
            return
        
        file_list = os.listdir(wallpapers_dir)
        batch_size = 20
        
        for i in range(0, len(file_list), batch_size):
            batch = file_list[i:i + batch_size]
            for filename in batch:
                if self._is_image(filename):
                    self.files.append(filename)
            
            self.files.sort()
            yield True
        
        self.files.sort()
        self._start_thumbnail_thread()
        yield False
    
    def _start_thumbnail_thread(self):
        """Start thumbnail loading thread"""
        thread = GLib.Thread.new("thumbnail-loader", self._preload_thumbnails, None)
    
    def _preload_thumbnails(self, _data):
        """Preload thumbnails in background"""
        futures = [
            self.executor.submit(self._process_file, file_name)
            for file_name in self.files
        ]
        concurrent.futures.wait(futures)
        GLib.idle_add(self._process_batch)
    
    def _process_file(self, file_name):
        """Process single wallpaper file"""
        wallpapers_dir = os.path.expanduser(data.get_default("wallpapers_dir", "~/Pictures/Wallpapers"))
        full_path = os.path.join(wallpapers_dir, file_name)
        cache_path = self._get_cache_path(file_name)
        
        if not os.path.exists(cache_path):
            try:
                with Image.open(full_path) as img:
                    width, height = img.size
                    side = min(width, height)
                    left = (width - side) // 2
                    top = (height - side) // 2
                    right = left + side
                    bottom = top + side
                    img_cropped = img.crop((left, top, right, bottom))
                    img_cropped.thumbnail((96, 96), Image.Resampling.LANCZOS)
                    img_cropped.save(cache_path, "PNG")
            except Exception as e:
                print(f"Error processing {file_name}: {e}")
                return
        
        self.thumbnail_queue.append((cache_path, file_name))
        GLib.idle_add(self._process_batch)
    
    def _process_batch(self):
        """Process batch of thumbnails"""
        batch = self.thumbnail_queue[:10]
        del self.thumbnail_queue[:10]
        
        for cache_path, file_name in batch:
            try:
                pixbuf = GdkPixbuf.Pixbuf.new_from_file(cache_path)
                self.thumbnails.append((pixbuf, file_name))
                self.viewport.get_model().append([pixbuf, file_name])
            except Exception as e:
                print(f"Error loading thumbnail {cache_path}: {e}")
        
        if self.thumbnail_queue:
            GLib.idle_add(self._process_batch)
        
        return False
    
    def _get_cache_path(self, file_name: str) -> str:
        """Get cache path for wallpaper"""
        file_hash = hashlib.md5(file_name.encode("utf-8")).hexdigest()
        return os.path.join(self.CACHE_DIR, f"{file_hash}.png")
    
    @staticmethod
    def _is_image(file_name: str) -> bool:
        """Check if file is an image"""
        return file_name.lower().endswith(
            (".png", ".jpg", ".jpeg", ".bmp", ".gif", ".webp")
        )
    
    def arrange_viewport(self, query: str = ""):
        """Filter and arrange wallpapers"""
        model = self.viewport.get_model()
        model.clear()
        
        filtered = [
            (thumb, name)
            for thumb, name in self.thumbnails
            if query.casefold() in name.casefold()
        ]
        filtered.sort(key=lambda x: x[1].lower())
        
        for pixbuf, file_name in filtered:
            model.append([pixbuf, file_name])
        
        if query.strip() == "":
            self.viewport.unselect_all()
            self.selected_index = -1
        elif len(model) > 0:
            self.viewport.select_path(Gtk.TreePath.new_from_indices([0]))
            self.selected_index = 0
    
    def on_wallpaper_selected(self, iconview, path):
        """Handle wallpaper selection"""
        model = iconview.get_model()
        file_name = model[path][1]
        wallpapers_dir = os.path.expanduser(data.get_default("wallpapers_dir", "~/Pictures/Wallpapers"))
        full_path = os.path.join(wallpapers_dir, file_name)
        
        current_wall = os.path.expanduser("~/.current.wall")
        if os.path.isfile(current_wall) or os.path.islink(current_wall):
            os.remove(current_wall)
        os.symlink(full_path, current_wall)
        
        # Set wallpaper with matugen
        exec_shell_command_async(f'matugen image "{full_path}"')
        print(f"Set wallpaper: {file_name}")
    
    def set_random_wallpaper(self, widget=None, external=False):
        """Set random wallpaper"""
        if not self.files:
            print("No wallpapers available")
            return
        
        file_name = random.choice(self.files)
        wallpapers_dir = os.path.expanduser(data.get_default("wallpapers_dir", "~/Pictures/Wallpapers"))
        full_path = os.path.join(wallpapers_dir, file_name)
        
        current_wall = os.path.expanduser("~/.current.wall")
        if os.path.isfile(current_wall) or os.path.islink(current_wall):
            os.remove(current_wall)
        os.symlink(full_path, current_wall)
        
        exec_shell_command_async(f'matugen image "{full_path}"')
        
        if external:
            exec_shell_command_async(
                f"notify-send '🎲 Wallpaper' 'Setting random wallpaper' -a 'SyndraShell' -i '{full_path}'"
            )
        
        print(f"Set random wallpaper: {file_name}")
    
    def setup_file_monitor(self):
        """Monitor wallpaper directory for changes"""
        wallpapers_dir = os.path.expanduser(data.get_default("wallpapers_dir", "~/Pictures/Wallpapers"))
        gfile = Gio.File.new_for_path(wallpapers_dir)
        self.file_monitor = gfile.monitor_directory(Gio.FileMonitorFlags.NONE, None)
        self.file_monitor.connect("changed", self.on_directory_changed)
    
    def on_directory_changed(self, monitor, file, other_file, event_type):
        """Handle directory changes"""
        file_name = file.get_basename()
        
        if event_type == Gio.FileMonitorEvent.DELETED:
            if file_name in self.files:
                self.files.remove(file_name)
                cache_path = self._get_cache_path(file_name)
                if os.path.exists(cache_path):
                    try:
                        os.remove(cache_path)
                    except Exception as e:
                        print(f"Error deleting cache: {e}")
                self.thumbnails = [(p, n) for p, n in self.thumbnails if n != file_name]
                GLib.idle_add(self.arrange_viewport, self.search_entry.get_text())
        
        elif event_type == Gio.FileMonitorEvent.CREATED:
            if self._is_image(file_name) and file_name not in self.files:
                self.files.append(file_name)
                self.files.sort()
                self.executor.submit(self._process_file, file_name)
