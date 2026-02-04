#!/usr/bin/env python3
"""
Syndra App Launcher - Menu d'applications moderne
Similaire au menu Windows avec logo Syndra
"""

import os
import gi
import subprocess
from pathlib import Path

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk, GdkPixbuf, Gio

class AppLauncher(Gtk.Window):
    def __init__(self):
        super().__init__(title="Syndra Launcher")
        
        # Configuration de la fenêtre
        self.set_default_size(600, 700)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_decorated(False)
        self.set_type_hint(Gdk.WindowTypeHint.DIALOG)
        
        # Style CSS
        self.setup_css()
        
        # Container principal
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        self.add(main_box)
        
        # Header avec logo Syndra
        self.create_header(main_box)
        
        # Barre de recherche
        self.create_search_bar(main_box)
        
        # Grille d'applications
        self.create_app_grid(main_box)
        
        # Charger les applications
        self.load_applications()
        
        # Événements
        self.connect("key-press-event", self.on_key_press)
        self.connect("focus-out-event", self.on_focus_out)
        
    def setup_css(self):
        """Configure le style CSS Iceland"""
        css_provider = Gtk.CssProvider()
        css = b"""
        window {
            background: linear-gradient(180deg, #e1f5fe 0%, #b3e5fc 100%);
            border: 3px solid #0288d1;
            border-radius: 15px;
        }
        
        .header {
            background: linear-gradient(135deg, #0288d1 0%, #0277bd 100%);
            padding: 15px;
            border-radius: 12px 12px 0 0;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        
        .logo-text {
            color: white;
            font-size: 28px;
            font-weight: bold;
            text-shadow: 2px 2px 6px rgba(0,0,0,0.4);
        }
        
        .close-button {
            background-color: #ef5350;
            color: white;
            border: none;
            border-radius: 50%;
            min-width: 36px;
            min-height: 36px;
            font-size: 18px;
            font-weight: bold;
            box-shadow: 0 2px 6px rgba(0,0,0,0.3);
        }
        
        .close-button:hover {
            background-color: #f44336;
            box-shadow: 0 4px 10px rgba(244, 67, 54, 0.5);
            transform: scale(1.1);
        }
        
        .search-entry {
            background-color: white;
            color: #01579b;
            border: 2px solid #4fc3f7;
            border-radius: 10px;
            padding: 12px;
            font-size: 14px;
        }
        
        .search-entry:focus {
            border-color: #0288d1;
            box-shadow: 0 0 12px rgba(2, 136, 209, 0.4);
        }
        
        .app-button {
            background: linear-gradient(180deg, #ffffff 0%, #e3f2fd 100%);
            border: 2px solid #81d4fa;
            border-radius: 10px;
            padding: 15px;
            margin: 5px;
        }
        
        .app-button:hover {
            background: linear-gradient(180deg, #e3f2fd 0%, #b3e5fc 100%);
            border-color: #0288d1;
            box-shadow: 0 4px 12px rgba(2, 136, 209, 0.3);
        }
        
        .app-name {
            color: #01579b;
            font-size: 12px;
            font-weight: 500;
        }
        
        .category-label {
            color: #01579b;
            font-weight: bold;
            font-size: 16px;
            padding: 10px;
            text-shadow: 1px 1px 2px rgba(255,255,255,0.8);
        }
        """
        css_provider.load_from_data(css)
        screen = Gdk.Screen.get_default()
        style_context = Gtk.StyleContext()
        style_context.add_provider_for_screen(
            screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )
    
    def create_header(self, container):
        """Crée le header avec logo et bouton fermer"""
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        header_box.get_style_context().add_class("header")
        header_box.set_size_request(-1, 80)
        container.pack_start(header_box, False, False, 0)
        
        # Logo avec icône snowflake
        logo_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        
        icon_label = Gtk.Label()
        icon_label.set_markup("<span size='32000'>❄️</span>")
        logo_box.pack_start(icon_label, False, False, 15)
        
        # Texte logo
        logo_label = Gtk.Label()
        logo_label.set_markup("<span class='logo-text'>SYNDRA ICELAND</span>")
        logo_label.get_style_context().add_class("logo-text")
        logo_box.pack_start(logo_label, False, False, 0)
        
        header_box.pack_start(logo_box, True, True, 0)
        
        # Bouton fermer visible
        close_btn = Gtk.Button(label="✕")
        close_btn.set_size_request(36, 36)
        close_btn.get_style_context().add_class("close-button")
        close_btn.set_tooltip_text("Fermer (ou ESC)")
        close_btn.connect("clicked", lambda w: self.close())
        header_box.pack_start(close_btn, False, False, 15)
    
    def create_search_bar(self, container):
        """Crée la barre de recherche"""
        search_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=0)
        search_box.set_margin_top(15)
        search_box.set_margin_bottom(15)
        search_box.set_margin_start(15)
        search_box.set_margin_end(15)
        
        self.search_entry = Gtk.Entry()
        self.search_entry.set_placeholder_text("🔍 Rechercher une application...")
        self.search_entry.get_style_context().add_class("search-entry")
        self.search_entry.connect("changed", self.on_search_changed)
        search_box.pack_start(self.search_entry, True, True, 0)
        
        container.pack_start(search_box, False, False, 0)
    
    def create_app_grid(self, container):
        """Crée la grille d'applications avec défilement"""
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC)
        scrolled.set_margin_start(15)
        scrolled.set_margin_end(15)
        scrolled.set_margin_bottom(15)
        
        # Box contenant toutes les catégories
        self.apps_container = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        scrolled.add(self.apps_container)
        
        container.pack_start(scrolled, True, True, 0)
    
    def load_applications(self):
        """Charge toutes les applications depuis les fichiers .desktop"""
        self.apps = []
        
        # Répertoires des applications
        app_dirs = [
            "/usr/share/applications",
            "/usr/local/share/applications",
            os.path.expanduser("~/.local/share/applications")
        ]
        
        for app_dir in app_dirs:
            if os.path.exists(app_dir):
                for filename in os.listdir(app_dir):
                    if filename.endswith(".desktop"):
                        app_path = os.path.join(app_dir, filename)
                        app_info = self.parse_desktop_file(app_path)
                        if app_info:
                            self.apps.append(app_info)
        
        # Trier par nom
        self.apps.sort(key=lambda x: x['name'].lower())
        
        # Grouper par catégorie
        self.display_apps_by_category()
    
    def parse_desktop_file(self, filepath):
        """Parse un fichier .desktop"""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            if "NoDisplay=true" in content or "Hidden=true" in content:
                return None
            
            app_info = {
                'name': '',
                'exec': '',
                'icon': '',
                'categories': [],
                'comment': ''
            }
            
            for line in content.split('\n'):
                if line.startswith('Name='):
                    app_info['name'] = line.split('=', 1)[1].strip()
                elif line.startswith('Exec='):
                    app_info['exec'] = line.split('=', 1)[1].strip()
                elif line.startswith('Icon='):
                    app_info['icon'] = line.split('=', 1)[1].strip()
                elif line.startswith('Categories='):
                    app_info['categories'] = line.split('=', 1)[1].strip().split(';')
                elif line.startswith('Comment='):
                    app_info['comment'] = line.split('=', 1)[1].strip()
            
            if app_info['name'] and app_info['exec']:
                return app_info
        except:
            pass
        return None
    
    def display_apps_by_category(self):
        """Affiche les applications groupées par catégorie"""
        # Définir les catégories principales
        categories = {
            'Favoris': ['Firefox', 'Kitty', 'Code', 'Thunar'],
            'Internet': ['Network', 'WebBrowser'],
            'Développement': ['Development', 'IDE'],
            'Bureautique': ['Office', 'TextEditor'],
            'Multimédia': ['Audio', 'Video', 'Graphics'],
            'Système': ['System', 'Settings'],
            'Autres': []
        }
        
        categorized = {cat: [] for cat in categories}
        uncategorized = []
        
        # Catégoriser les applications
        for app in self.apps:
            placed = False
            for cat_name, cat_keywords in categories.items():
                if cat_name == 'Favoris':
                    if any(fav.lower() in app['name'].lower() for fav in cat_keywords):
                        categorized[cat_name].append(app)
                        placed = True
                        break
                else:
                    if any(keyword in ' '.join(app['categories']) for keyword in cat_keywords):
                        categorized[cat_name].append(app)
                        placed = True
                        break
            
            if not placed:
                uncategorized.append(app)
        
        categorized['Autres'] = uncategorized
        
        # Afficher chaque catégorie
        for cat_name, cat_apps in categorized.items():
            if cat_apps:
                self.create_category_section(cat_name, cat_apps)
    
    def create_category_section(self, category_name, apps):
        """Crée une section de catégorie"""
        # Label de catégorie
        cat_label = Gtk.Label()
        cat_label.set_markup(f"<b>{category_name}</b>")
        cat_label.set_xalign(0)
        cat_label.get_style_context().add_class("category-label")
        self.apps_container.pack_start(cat_label, False, False, 5)
        
        # Grille d'applications (4 colonnes)
        grid = Gtk.FlowBox()
        grid.set_valign(Gtk.Align.START)
        grid.set_max_children_per_line(4)
        grid.set_selection_mode(Gtk.SelectionMode.NONE)
        grid.set_homogeneous(True)
        grid.set_column_spacing(10)
        grid.set_row_spacing(10)
        
        for app in apps[:8]:  # Limiter à 8 apps par catégorie
            app_button = self.create_app_button(app)
            grid.add(app_button)
        
        self.apps_container.pack_start(grid, False, False, 0)
        
        # Séparateur
        sep = Gtk.Separator(orientation=Gtk.Orientation.HORIZONTAL)
        sep.set_margin_top(10)
        sep.set_margin_bottom(5)
        self.apps_container.pack_start(sep, False, False, 0)
    
    def create_app_button(self, app):
        """Crée un bouton d'application"""
        button = Gtk.Button()
        button.get_style_context().add_class("app-button")
        button.set_relief(Gtk.ReliefStyle.NONE)
        
        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        box.set_margin_top(10)
        box.set_margin_bottom(10)
        
        # Icône
        icon_name = app['icon'] if app['icon'] else 'application-x-executable'
        try:
            icon = Gtk.Image.new_from_icon_name(icon_name, Gtk.IconSize.DIALOG)
        except:
            icon = Gtk.Image.new_from_icon_name('application-x-executable', Gtk.IconSize.DIALOG)
        
        box.pack_start(icon, False, False, 0)
        
        # Nom
        label = Gtk.Label()
        label.set_markup(f"<span size='small'>{app['name'][:15]}</span>")
        label.set_line_wrap(True)
        label.set_max_width_chars(15)
        label.get_style_context().add_class("app-name")
        box.pack_start(label, False, False, 0)
        
        button.add(box)
        button.connect("clicked", self.on_app_clicked, app)
        
        # Tooltip avec description
        if app['comment']:
            button.set_tooltip_text(app['comment'])
        
        return button
    
    def on_app_clicked(self, button, app):
        """Lance une application"""
        try:
            # Nettoyer la commande exec
            exec_cmd = app['exec']
            exec_cmd = exec_cmd.replace('%U', '').replace('%F', '').replace('%f', '')
            exec_cmd = exec_cmd.replace('%u', '').strip()
            
            subprocess.Popen(exec_cmd, shell=True, start_new_session=True)
            self.destroy()
        except Exception as e:
            print(f"Erreur lors du lancement de {app['name']}: {e}")
    
    def on_search_changed(self, entry):
        """Filtre les applications selon la recherche"""
        search_text = entry.get_text().lower()
        
        # Cacher toutes les catégories d'abord
        for child in self.apps_container.get_children():
            child.hide()
        
        if not search_text:
            # Réafficher tout
            for child in self.apps_container.get_children():
                child.show_all()
            return
        
        # Filtrer et afficher les résultats
        filtered_apps = [app for app in self.apps if search_text in app['name'].lower()]
        
        if filtered_apps:
            # Nettoyer le container
            for child in self.apps_container.get_children():
                self.apps_container.remove(child)
            
            # Afficher les résultats
            self.create_category_section("Résultats", filtered_apps[:16])
            self.apps_container.show_all()
    
    def on_key_press(self, widget, event):
        """Gère les touches clavier"""
        if event.keyval == Gdk.KEY_Escape:
            self.destroy()
            return True
    
    def on_focus_out(self, widget, event):
        """Ferme la fenêtre si elle perd le focus"""
        # self.destroy()  # Commenté pour éviter la fermeture accidentelle
        pass

def main():
    launcher = AppLauncher()
    launcher.connect("destroy", Gtk.main_quit)
    launcher.show_all()
    launcher.present()
    Gtk.main()

if __name__ == "__main__":
    main()
