#!/usr/bin/env python3
"""
SyndraShell - Main Application
Powered by Fabric Framework
Inspired by Ax-Shell by Axenide
"""

import ctypes
import ctypes.util
import os
import sys

import gi

gi.require_version("GLib", "2.0")

# S'assurer que le répertoire du script est dans sys.path
_script_dir = os.path.dirname(os.path.abspath(__file__))
if _script_dir not in sys.path:
    sys.path.insert(0, _script_dir)

def _ensure_tabler_icons_font():
    """
    Copie tabler-icons dans ~/.fonts/ (exactement comme ax-shell install.sh)
    et reconstruit le cache fontconfig.
    """
    import shutil, subprocess
    font_src = os.path.join(_script_dir, "assets", "fonts", "tabler-icons", "tabler-icons.ttf")
    if not os.path.isfile(font_src):
        return

    # Copie vers ~/.fonts/tabler-icons/ — emplacement utilisé par ax-shell
    for dest_dir in [
        os.path.expanduser("~/.fonts/tabler-icons"),
        os.path.expanduser("~/.local/share/fonts/tabler-icons"),
    ]:
        dest_file = os.path.join(dest_dir, "tabler-icons.ttf")
        if not os.path.isfile(dest_file):
            os.makedirs(dest_dir, exist_ok=True)
            shutil.copy2(font_src, dest_file)

    # Rebuild fontconfig cache pour les fonts utilisateur
    subprocess.run(["fc-cache", "-f"], capture_output=True)

    # Enregistrement immédiat via fontconfig pour ce processus
    try:
        lib_name = ctypes.util.find_library("fontconfig")
        if lib_name:
            libfc = ctypes.CDLL(lib_name)
            libfc.FcConfigGetCurrent.restype = ctypes.c_void_p
            libfc.FcConfigAppFontAddDir.restype = ctypes.c_bool
            libfc.FcConfigAppFontAddDir.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
            cfg = libfc.FcConfigGetCurrent()
            font_dir = os.path.join(_script_dir, "assets", "fonts", "tabler-icons")
            libfc.FcConfigAppFontAddDir(cfg, font_dir.encode())
    except Exception:
        pass

_ensure_tabler_icons_font()

def _load_tabler_icons_css():
    """
    Charge la police tabler-icons via un CssProvider GTK avec chemin absolu.
    Appelé APRÈS init GTK (après Application()), donc Gdk.Screen est disponible.
    """
    try:
        gi.require_version("Gtk", "3.0")
        gi.require_version("Gdk", "3.0")
        from gi.repository import Gdk, Gtk
        font_path = os.path.join(_script_dir, "assets", "fonts", "tabler-icons", "tabler-icons.ttf")
        if not os.path.isfile(font_path):
            return
        css = f'@font-face {{ font-family: "tabler-icons"; src: url("{font_path}"); }}'
        provider = Gtk.CssProvider()
        provider.load_from_data(css.encode())
        screen = Gdk.Screen.get_default()
        if screen:
            Gtk.StyleContext.add_provider_for_screen(
                screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_USER + 1
            )
    except Exception as e:
        print(f"[font] tabler-icons load failed: {e}")

try:
    import setproctitle
    from fabric import Application
    from fabric.utils import exec_shell_command_async, get_relative_path
    from gi.repository import GLib
except ImportError as e:
    print(f"Erreur: dépendance manquante — {e}")
    print("Installez les dépendances avec: pip install -r requirements.txt")
    print("Et assurez-vous que python-fabric-git est installé (AUR).")
    sys.exit(1)

from config.data import APP_NAME, APP_NAME_CAP, CACHE_DIR, CONFIG_FILE, HOME_DIR
from modules.bar import Bar
from modules.corners import Corners
from modules.dock import Dock
from modules.notch import Notch
from modules.notifications import NotificationPopup

fonts_updated_file = f"{CACHE_DIR}/fonts_updated"


def handle_uninstall():
    """Handle the uninstall command"""
    print("=" * 63)
    print("              SYNDRA SHELL - UNINSTALL")
    print("=" * 63)
    print()
    print("  WARNING: This will remove:")
    print()
    print(f"  - SyndraShell (~/.config/{APP_NAME_CAP})")
    print(f"  - Cache (~/.cache/{APP_NAME})")
    print("  - Current wallpaper symlink (~/.current.wall)")
    print()

    response = input("Do you really want to uninstall SyndraShell? [y/N]: ").strip().lower()

    if response != 'y':
        print("Uninstall cancelled.")
        sys.exit(0)

    print()
    print("Uninstalling...")
    print()

    import shutil

    def safe_remove(path):
        """Safely remove a file or directory"""
        expanded_path = os.path.expanduser(path)
        if os.path.exists(expanded_path):
            print(f"  Removing: {path}")
            if os.path.isdir(expanded_path):
                shutil.rmtree(expanded_path)
            else:
                os.remove(expanded_path)
        else:
            print(f"  Already absent: {path}")

    # Stop running processes
    print("1/3 - Stopping SyndraShell processes...")
    os.system(f"pkill -f {APP_NAME} 2>/dev/null || true")
    os.system(f"pkill -f '{APP_NAME_CAP}/main.py' 2>/dev/null || true")

    # Remove SyndraShell config
    print()
    print("2/3 - Removing configuration...")
    safe_remove(f"~/.config/{APP_NAME_CAP}")

    # Remove cache
    print()
    print("3/3 - Removing cache...")
    safe_remove(f"~/.cache/{APP_NAME}")
    safe_remove("~/.current.wall")

    print()
    print("=" * 63)
    print("  SyndraShell has been removed from your system.")
    print("=" * 63)
    print()
    sys.exit(0)


if __name__ == "__main__":
    # Check for uninstall command
    if len(sys.argv) > 1 and sys.argv[1].lower() in ['uninstall', 'remove']:
        handle_uninstall()

    setproctitle.setproctitle(APP_NAME)

    # Ensure config exists
    if not os.path.isfile(CONFIG_FILE):
        config_script_path = get_relative_path("config/config.py")
        exec_shell_command_async(f"python {config_script_path}")

    # Set default wallpaper if none exists
    current_wallpaper = os.path.expanduser("~/.current.wall")
    wallpapers_dir = os.path.expanduser("~/Pictures/Wallpapers")
    example_wallpaper = os.path.expanduser(
        f"~/.config/{APP_NAME_CAP}/assets/wallpapers_example/example-1.jpg"
    )

    # Create wallpapers directory
    os.makedirs(wallpapers_dir, exist_ok=True)

    # Copy example wallpaper to wallpapers directory if empty
    if not os.listdir(wallpapers_dir):
        if os.path.exists(example_wallpaper):
            os.system(f"cp '{example_wallpaper}' '{wallpapers_dir}/'")

    # Set current wallpaper
    if not os.path.exists(current_wallpaper):
        if os.path.exists(example_wallpaper):
            os.symlink(example_wallpaper, current_wallpaper)
        elif os.listdir(wallpapers_dir):
            first_wall = os.path.join(wallpapers_dir, os.listdir(wallpapers_dir)[0])
            os.symlink(first_wall, current_wallpaper)

    # Apply wallpaper with swww or swaybg
    if os.path.exists(current_wallpaper):
        video_extensions = (".mp4", ".webm", ".mkv", ".avi", ".mov")
        is_video = current_wallpaper.lower().endswith(video_extensions)

        if is_video:
            exec_shell_command_async("killall mpvpaper 2>/dev/null || true")
            GLib.timeout_add_seconds(1, lambda: exec_shell_command_async(
                f"mpvpaper -o 'loop' '*' '{current_wallpaper}' >/dev/null 2>&1 &"
            ))
        else:
            exec_shell_command_async("swww-daemon --format xrgb >/dev/null 2>&1 || true")
            GLib.timeout_add_seconds(2, lambda: exec_shell_command_async(
                f"swww img '{current_wallpaper}' --transition-type fade --transition-duration 2"
            ) or True)

    # Download fonts if not already done
    if not os.path.exists(fonts_updated_file):
        os.makedirs(CACHE_DIR, exist_ok=True)

        def download_fonts():
            font_dir = os.path.expanduser("~/.fonts")
            os.makedirs(font_dir, exist_ok=True)
            os.system(
                f"wget -q https://github.com/zed-industries/zed-fonts/releases/latest/download/zed-sans.zip -O /tmp/zed-sans.zip && "
                f"unzip -q -o /tmp/zed-sans.zip -d {font_dir} && "
                f"rm /tmp/zed-sans.zip"
            )
            os.system("fc-cache -f")
            with open(fonts_updated_file, "w") as f:
                f.write("1")
            print("Fonts downloaded successfully")

        GLib.idle_add(download_fonts)

    # Load configuration
    from config.data import load_config

    config = load_config()

    # Initialize multi-monitor services
    try:
        from utils.monitor_manager import get_monitor_manager
        from services.monitor_focus import get_monitor_focus_service
        from utils.global_keybinds import init_global_keybind_objects

        monitor_manager = get_monitor_manager()
        monitor_focus_service = get_monitor_focus_service()
        monitor_manager.set_monitor_focus_service(monitor_focus_service)
        init_global_keybind_objects()

        # Get all available monitors
        all_monitors = monitor_manager.get_monitors()
        multi_monitor_enabled = True
    except ImportError:
        # Fallback to single monitor mode
        all_monitors = [{'id': 0, 'name': 'default'}]
        monitor_manager = None
        multi_monitor_enabled = False

    # Filter monitors based on selected_monitors configuration
    selected_monitors_config = config.get("selected_monitors", [])

    if not selected_monitors_config:
        monitors = all_monitors
        print(f"SyndraShell: No specific monitors selected, showing on all monitors")
    else:
        monitors = []
        selected_monitor_names = set(selected_monitors_config)

        for monitor in all_monitors:
            monitor_name = monitor.get('name', f'monitor-{monitor.get("id", 0)}')
            if monitor_name in selected_monitor_names:
                monitors.append(monitor)
                print(f"SyndraShell: Including monitor '{monitor_name}' (selected)")
            else:
                print(f"SyndraShell: Excluding monitor '{monitor_name}' (not selected)")

        # Fallback: if no valid monitors found, use all monitors
        if not monitors:
            print("SyndraShell: No valid selected monitors found, falling back to all monitors")
            monitors = all_monitors

    # Create application components list
    app_components = []
    corners = None
    notification = None

    # Create components for each monitor
    for monitor in monitors:
        monitor_id = monitor['id']

        # Create corners only for the first monitor (shared across all)
        if monitor_id == 0:
            corners = Corners()
            corners_visible = config.get("corners_visible", True)
            corners.set_visible(corners_visible)
            app_components.append(corners)

        # Create monitor-specific components
        if multi_monitor_enabled:
            bar = Bar(monitor_id=monitor_id)
            notch = Notch(monitor_id=monitor_id)
            dock = Dock(monitor_id=monitor_id)
        else:
            bar = Bar()
            notch = Notch()
            dock = Dock()

        # Connect bar and notch
        bar.notch = notch
        notch.bar = bar

        # Create notification popup for the first monitor only
        if monitor_id == 0:
            notification = NotificationPopup(widgets=notch.dashboard.widgets)
            app_components.append(notification)

        # Register instances in monitor manager if available
        if multi_monitor_enabled and monitor_manager:
            monitor_manager.register_monitor_instances(monitor_id, {
                'bar': bar,
                'notch': notch,
                'dock': dock,
                'corners': corners if monitor_id == 0 else None
            })

        # Add components to app list
        app_components.extend([bar, notch, dock])

    # Create the application with all components
    app = Application(f"{APP_NAME}", *app_components)

    def set_css():
        from gi.repository import Gdk, Gtk
        css_path = get_relative_path("main.css")

        # Utilise load_from_path (résout les @imports depuis le dossier du fichier)
        # et connecte parsing-error pour éviter que PyGObject 3.14+ lève une exception
        provider = Gtk.CssProvider()
        provider.connect("parsing-error", lambda p, s, e: None)
        try:
            provider.load_from_path(css_path)
        except Exception as e:
            print(f"[CSS] erreur ignorée : {e}")

        screen = Gdk.Screen.get_default()
        if screen:
            Gtk.StyleContext.add_provider_for_screen(
                screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            )

        _load_tabler_icons_css()

    app.set_css = set_css
    app.set_css()

    app.run()
