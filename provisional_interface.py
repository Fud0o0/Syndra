#!/usr/bin/env python3
"""
Interface Provisoire - SyndraShell
Interface de test/développement simple
"""

import gi
import sys
import os

# Vérifier que GTK peut être initialisé
gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
try:
    from gi.repository import Gtk, Gdk, GLib
    if not Gtk.init_check()[0]:
        print("❌ Erreur: GTK ne peut pas être initialisé")
        print("   Assurez-vous d'être dans une session graphique (X11/Wayland)")
        print("   Variables d'environnement:")
        print(f"   - DISPLAY: {os.environ.get('DISPLAY', 'non défini')}")
        print(f"   - WAYLAND_DISPLAY: {os.environ.get('WAYLAND_DISPLAY', 'non défini')}")
        sys.exit(1)
except Exception as e:
    print(f"❌ Erreur lors de l'import de GTK: {e}")
    sys.exit(1)

class ProvisionalInterface(Gtk.Window):
    def __init__(self):
        super().__init__(title="SyndraShell - Interface Provisoire")
        self.set_default_size(800, 600)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_decorated(False)  # Pas de décoration système
        
        # Style CSS Iceland
        self.setup_iceland_css()
        
        # Container principal
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        self.add(main_box)
        
        # Header personnalisé avec bouton fermer
        self.create_custom_header(main_box)
        
        # Container du contenu
        content_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        content_box.set_margin_top(10)
        content_box.set_margin_bottom(20)
        content_box.set_margin_start(20)
        content_box.set_margin_end(20)
        main_box.pack_start(content_box, True, True, 0)
        
        # Notebook pour différentes sections
        notebook = Gtk.Notebook()
        content_box.pack_start(notebook, True, True, 0)
        
        # Page 1: Informations système
        self.create_system_page(notebook)
        
        # Page 2: Modules
        self.create_modules_page(notebook)
        
        # Page 3: Configuration
        self.create_config_page(notebook)
        
        # Barre de statut
        statusbar = Gtk.Statusbar()
        context_id = statusbar.get_context_id("status")
        statusbar.push(context_id, "Interface Iceland prête ❄️")
        content_box.pack_start(statusbar, False, False, 0)
    
    def create_system_page(self, notebook):
        """Page d'informations système"""
        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        box.set_margin_top(10)
        box.set_margin_bottom(10)
        box.set_margin_start(10)
        box.set_margin_end(10)
        
        # Info label
        info_label = Gtk.Label()
        info_label.set_markup("<b>Informations Système</b>")
        box.pack_start(info_label, False, False, 5)
        
        # Grid pour les informations
        grid = Gtk.Grid()
        grid.set_column_spacing(10)
        grid.set_row_spacing(5)
        
        # Récupérer quelques infos
        user = os.environ.get('USER', 'inconnu')
        home = os.environ.get('HOME', 'inconnu')
        shell = os.environ.get('SHELL', 'inconnu')
        
        infos = [
            ("Utilisateur:", user),
            ("Home:", home),
            ("Shell:", shell),
            ("Distribution:", "Arch Linux (Hyprland)"),
            ("Framework:", "Fabric + Python GTK"),
        ]
        
        for i, (label_text, value_text) in enumerate(infos):
            label = Gtk.Label()
            label.set_markup(f"<b>{label_text}</b>")
            label.set_halign(Gtk.Align.END)
            grid.attach(label, 0, i, 1, 1)
            
            value = Gtk.Label(label=value_text)
            value.set_halign(Gtk.Align.START)
            grid.attach(value, 1, i, 1, 1)
        
        box.pack_start(grid, False, False, 10)
        
        # Bouton de test
        test_button = Gtk.Button(label="Rafraîchir les informations")
        test_button.connect("clicked", self.on_refresh_clicked)
        box.pack_start(test_button, False, False, 10)
        
        notebook.append_page(box, Gtk.Label(label="Système"))
    
    def create_modules_page(self, notebook):
        """Page pour tester les modules"""
        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        box.set_margin_top(10)
        box.set_margin_bottom(10)
        box.set_margin_start(10)
        box.set_margin_end(10)
        
        # Titre
        title = Gtk.Label()
        title.set_markup("<b>Modules SyndraShell</b>")
        box.pack_start(title, False, False, 5)
        
        # Liste des modules disponibles
        modules_list = [
            ("Bar", "Barre supérieure", "modules.bar"),
            ("Dock", "Dock d'applications", "modules.dock"),
            ("Notch", "Zone de notifications", "modules.notch"),
            ("Dashboard", "Tableau de bord", "modules.dashboard"),
            ("Wallpapers", "Gestion des fonds d'écran", "modules.wallpapers"),
            ("Icons", "Gestionnaire d'icônes", "modules.icons"),
        ]
        
        # Grid pour les modules
        modules_grid = Gtk.Grid()
        modules_grid.set_column_spacing(10)
        modules_grid.set_row_spacing(10)
        
        for i, (name, desc, module) in enumerate(modules_list):
            # Frame pour chaque module
            frame = Gtk.Frame()
            frame.set_label(name)
            
            vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=5)
            vbox.set_margin_top(5)
            vbox.set_margin_bottom(5)
            vbox.set_margin_start(5)
            vbox.set_margin_end(5)
            
            desc_label = Gtk.Label(label=desc)
            desc_label.set_line_wrap(True)
            vbox.pack_start(desc_label, False, False, 0)
            
            test_btn = Gtk.Button(label="Tester")
            test_btn.connect("clicked", self.on_module_test, name)
            vbox.pack_start(test_btn, False, False, 5)
            
            frame.add(vbox)
            
            row = i // 2
            col = i % 2
            modules_grid.attach(frame, col, row, 1, 1)
        
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled.add(modules_grid)
        
        box.pack_start(scrolled, True, True, 0)
        
        notebook.append_page(box, Gtk.Label(label="Modules"))
    
    def create_config_page(self, notebook):
        """Page de configuration rapide"""
        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        box.set_margin_top(10)
        box.set_margin_bottom(10)
        box.set_margin_start(10)
        box.set_margin_end(10)
        
        # Titre
        title = Gtk.Label()
        title.set_markup("<b>Configuration Provisoire</b>")
        box.pack_start(title, False, False, 5)
        
        # Options de configuration
        config_options = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        
        # Option 1: Sélection de thème visuel
        theme_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        theme_label = Gtk.Label(label="Thème visuel:")
        theme_combo = Gtk.ComboBoxText()
        theme_combo.append("iceland", "❄️ Iceland (Glacier)")
        theme_combo.append("tokyo_night", "🌃 Tokyo Night")
        theme_combo.append("sunset", "🌅 Sunset")
        theme_combo.append("forest", "🌲 Forest")
        theme_combo.append("purple_haze", "🔮 Purple Haze")
        theme_combo.append("cyberpunk", "🤖 Cyberpunk")
        theme_combo.set_active_id("iceland")
        theme_combo.connect("changed", self.on_theme_changed)
        theme_box.pack_start(theme_label, False, False, 0)
        theme_box.pack_start(theme_combo, True, True, 0)
        config_options.pack_start(theme_box, False, False, 0)
        
        # Option 2: Thème de sécurité
        security_theme_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        security_theme_label = Gtk.Label(label="Profil de sécurité:")
        security_theme_combo = Gtk.ComboBoxText()
        security_theme_combo.append_text("Blue Team")
        security_theme_combo.append_text("Red Team")
        security_theme_combo.append_text("Purple Team")
        security_theme_combo.append_text("Root Me")
        security_theme_combo.set_active(0)
        security_theme_box.pack_start(security_theme_label, False, False, 0)
        security_theme_box.pack_start(security_theme_combo, True, True, 0)
        config_options.pack_start(security_theme_box, False, False, 0)
        
        # Option 2: Thème de sécurité
        security_theme_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        security_theme_label = Gtk.Label(label="Profil de sécurité:")
        security_theme_combo = Gtk.ComboBoxText()
        security_theme_combo.append_text("Blue Team")
        security_theme_combo.append_text("Red Team")
        security_theme_combo.append_text("Purple Team")
        security_theme_combo.append_text("Root Me")
        security_theme_combo.set_active(0)
        security_theme_box.pack_start(security_theme_label, False, False, 0)
        security_theme_box.pack_start(security_theme_combo, True, True, 0)
        config_options.pack_start(security_theme_box, False, False, 0)
        
        # Option 3: Transparence
        transparency_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        transparency_label = Gtk.Label(label="Transparence:")
        transparency_scale = Gtk.Scale.new_with_range(
            Gtk.Orientation.HORIZONTAL, 0, 100, 5
        )
        transparency_scale.set_value(80)
        transparency_scale.set_digits(0)
        transparency_scale.set_value_pos(Gtk.PositionType.RIGHT)
        transparency_box.pack_start(transparency_label, False, False, 0)
        transparency_box.pack_start(transparency_scale, True, True, 0)
        config_options.pack_start(transparency_box, False, False, 0)
        
        # Option 4: Lancement automatique
        autostart_switch = Gtk.Switch()
        autostart_file = os.path.expanduser("~/.config/autostart/syndra-provisional.desktop")
        autostart_switch.set_active(os.path.exists(autostart_file))
        autostart_switch.connect("notify::active", self.on_autostart_toggled)
        autostart_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        autostart_label = Gtk.Label(label="Lancement au démarrage:")
        autostart_box.pack_start(autostart_label, False, False, 0)
        autostart_box.pack_start(autostart_switch, False, False, 0)
        config_options.pack_start(autostart_box, False, False, 0)
        
        box.pack_start(config_options, False, False, 10)
        
        # Boutons d'action
        button_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        button_box.set_halign(Gtk.Align.CENTER)
        
        apply_btn = Gtk.Button(label="Appliquer")
        apply_btn.connect("clicked", self.on_apply_config)
        button_box.pack_start(apply_btn, False, False, 0)
        
        reset_btn = Gtk.Button(label="Réinitialiser")
        reset_btn.connect("clicked", self.on_reset_config)
        button_box.pack_start(reset_btn, False, False, 0)
        
        box.pack_start(button_box, False, False, 10)
        
        # Zone de texte pour les logs
        logs_frame = Gtk.Frame(label="Logs")
        logs_textview = Gtk.TextView()
        logs_textview.set_editable(False)
        logs_textview.get_buffer().set_text("Prêt pour la configuration...")
        
        scrolled_logs = Gtk.ScrolledWindow()
        scrolled_logs.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled_logs.add(logs_textview)
        logs_frame.add(scrolled_logs)
        
        box.pack_start(logs_frame, True, True, 0)
        
        notebook.append_page(box, Gtk.Label(label="Configuration"))
    
    def on_refresh_clicked(self, button):
        """Callback pour le bouton rafraîchir"""
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Informations rafraîchies",
        )
        dialog.format_secondary_text(
            "Les informations système ont été mises à jour."
        )
        dialog.run()
        dialog.destroy()
    
    def on_module_test(self, button, module_name):
        """Callback pour tester un module"""
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text=f"Test du module {module_name}",
        )
        dialog.format_secondary_text(
            f"Le module '{module_name}' sera testé.\n"
            "Fonctionnalité en développement..."
        )
        dialog.run()
        dialog.destroy()
    
    def on_theme_changed(self, combo):
        """Changer le thème dynamiquement"""
        theme_id = combo.get_active_id()
        if theme_id:
            try:
                # Import du module themes
                import sys
                config_path = os.path.join(os.path.dirname(__file__), "config")
                if config_path not in sys.path:
                    sys.path.insert(0, config_path)
                
                from themes import get_theme_css, THEMES
                
                # Appliquer le nouveau CSS
                css_provider = Gtk.CssProvider()
                css = get_theme_css(theme_id).encode()
                css_provider.load_from_data(css)
                
                from gi.repository import Gdk
                screen = Gdk.Screen.get_default()
                style_context = Gtk.StyleContext()
                style_context.add_provider_for_screen(
                    screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
                )
                
                # Mise à jour du titre avec l'icône du thème
                theme = THEMES[theme_id]
                title_text = f"SyndraShell - {theme['name']} {theme['icon']}"
                self.set_title(title_text)
                
                # Afficher confirmation
                dialog = Gtk.MessageDialog(
                    transient_for=self,
                    flags=0,
                    message_type=Gtk.MessageType.INFO,
                    buttons=Gtk.ButtonsType.OK,
                    text=f"Thème {theme['name']} appliqué",
                )
                dialog.format_secondary_text(theme['description'])
                dialog.run()
                dialog.destroy()
                
            except Exception as e:
                dialog = Gtk.MessageDialog(
                    transient_for=self,
                    flags=0,
                    message_type=Gtk.MessageType.ERROR,
                    buttons=Gtk.ButtonsType.OK,
                    text="Erreur lors du changement de thème",
                )
                dialog.format_secondary_text(str(e))
                dialog.run()
                dialog.destroy()

    
    def on_apply_config(self, button):
        """Appliquer la configuration"""
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Configuration appliquée",
        )
        dialog.format_secondary_text(
            "Les paramètres ont été appliqués avec succès."
        )
        dialog.run()
        dialog.destroy()
    
    def on_reset_config(self, button):
        """Réinitialiser la configuration"""
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.WARNING,
            buttons=Gtk.ButtonsType.YES_NO,
            text="Confirmer la réinitialisation",
        )
        dialog.format_secondary_text(
            "Êtes-vous sûr de vouloir réinitialiser la configuration?"
        )
        response = dialog.run()
        dialog.destroy()
        
        if response == Gtk.ResponseType.YES:
            info_dialog = Gtk.MessageDialog(
                transient_for=self,
                flags=0,
                message_type=Gtk.MessageType.INFO,
                buttons=Gtk.ButtonsType.OK,
                text="Configuration réinitialisée",
            )
            info_dialog.format_secondary_text(
                "Les paramètres par défaut ont été restaurés."
            )
            info_dialog.run()
            info_dialog.destroy()
    
    def on_autostart_toggled(self, switch, gparam):
        """Activer/désactiver le lancement automatique"""
        autostart_dir = os.path.expanduser("~/.config/autostart")
        autostart_file = os.path.join(autostart_dir, "syndra-provisional.desktop")
        desktop_file = os.path.expanduser("~/.local/share/applications/syndra-provisional.desktop")
        
        if switch.get_active():
            # Activer l'autostart
            os.makedirs(autostart_dir, exist_ok=True)
            if os.path.exists(desktop_file):
                import shutil
                shutil.copy(desktop_file, autostart_file)
                dialog = Gtk.MessageDialog(
                    transient_for=self,
                    flags=0,
                    message_type=Gtk.MessageType.INFO,
                    buttons=Gtk.ButtonsType.OK,
                    text="Lancement automatique activé",
                )
                dialog.format_secondary_text(
                    "L'interface se lancera automatiquement au démarrage."
                )
                dialog.run()
                dialog.destroy()
        else:
            # Désactiver l'autostart
            if os.path.exists(autostart_file):
                os.remove(autostart_file)
                dialog = Gtk.MessageDialog(
                    transient_for=self,
                    flags=0,
                    message_type=Gtk.MessageType.INFO,
                    buttons=Gtk.ButtonsType.OK,
                    text="Lancement automatique désactivé",
                )
                dialog.format_secondary_text(
                    "L'interface ne se lancera plus au démarrage."
                )
                dialog.run()
                dialog.destroy()

def main():
    """Point d'entrée principal"""
    # Afficher un message de bienvenue dans le terminal
    print("╔═══════════════════════════════════════════════════════════════╗")
    print("║        🎨 SyndraShell - Interface Provisoire 🎨              ║")
    print("╠═══════════════════════════════════════════════════════════════╣")
    print("║  Interface de développement et de test                       ║")
    print("║                                                               ║")
    print("║  Fonctionnalités:                                            ║")
    print("║  • Test des modules sans Hyprland                            ║")
    print("║  • Configuration rapide (thèmes, autostart)                  ║")
    print("║  • Vue d'ensemble du système                                 ║")
    print("║                                                               ║")
    print("║  💡 Astuce: Utilisez l'onglet Configuration pour gérer      ║")
    print("║     le lancement automatique au démarrage                    ║")
    print("╚═══════════════════════════════════════════════════════════════╝")
    print()
    
    app = ProvisionalInterface()
    app.connect("destroy", Gtk.main_quit)
    app.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()
