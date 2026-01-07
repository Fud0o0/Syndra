"""
Dashboard module for SyndraShell
Displays wallpaper selector, tools, and system information
"""
from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.notebook import Notebook
from fabric.widgets.button import Button
from fabric.widgets.image import Image
from gi.repository import Gtk, GLib
import json
import os

from modules.wallpapers import WallpaperSelector
from modules.tools import Toolbox
import config.data as data


class Dashboard(Box):
    """Dashboard with wallpapers, tools, and widgets"""
    
    def __init__(self, **kwargs):
        super().__init__(
            name="dashboard",
            orientation="v",
            spacing=0,
            h_expand=True,
            v_expand=True,
            **kwargs,
        )
        
        # Load config
        self.config_path = os.path.expanduser("~/.config/syndrashell/config.json")
        self.load_config()
        
        # Header with GitHub profile
        header = self.create_header()
        
        # Team selector
        team_selector = self.create_team_selector()
        
        # Notebook for tabs
        self.notebook = Notebook(
            name="dashboard-notebook",
            h_expand=True,
            v_expand=True,
            show_border=False,
        )
        
        # Wallpapers tab
        wallpapers_page = WallpaperSelector()
        wallpapers_label = Label(label="🖼️ Wallpapers")
        self.notebook.append_page(wallpapers_page, wallpapers_label)
        
        # Tools tab
        tools_page = Toolbox()
        tools_label = Label(label="🛠️ Tools")
        self.notebook.append_page(tools_page, tools_label)
        
        # Widgets tab (placeholder)
        widgets_page = Box(
            orientation="v",
            spacing=8,
            children=[
                Label(
                    label="📊 Widgets",
                    name="section-title",
                ),
                Label(
                    label="Coming soon...",
                    name="placeholder-text",
                ),
            ],
        )
        widgets_label = Label(label="📊 Widgets")
        self.notebook.append_page(widgets_page, widgets_label)
        
        # Assemble dashboard
        self.children = [header, team_selector, self.notebook]
        
        # Apply current team theme
        self.apply_team_theme()
    
    def load_config(self):
        """Load configuration from file"""
        try:
            with open(self.config_path, 'r') as f:
                self.config = json.load(f)
        except FileNotFoundError:
            # Default config
            self.config = {
                "user": {
                    "github_username": "Fud0o0",
                    "name": "Fud0o0",
                    "profile_image": "https://github.com/Fud0o0.png"
                },
                "team": "purple"
            }
            self.save_config()
    
    def save_config(self):
        """Save configuration to file"""
        os.makedirs(os.path.dirname(self.config_path), exist_ok=True)
        with open(self.config_path, 'w') as f:
            json.dump(self.config, f, indent=2)
    
    def create_header(self):
        """Create header with GitHub profile"""
        # Profile image (using Label as placeholder - you can use Image widget if needed)
        profile_box = Box(
            name="dashboard-profile",
            orientation="h",
            spacing=12,
            h_align="center",
        )
        
        # GitHub link button
        github_username = self.config.get("user", {}).get("github_username", "Fud0o0")
        user_name = self.config.get("user", {}).get("name", "Fud0o0")
        
        github_button = Button(
            name="github-link",
            child=Box(
                orientation="h",
                spacing=8,
                children=[
                    Label(
                        label="👤",
                        name="profile-icon",
                    ),
                    Label(
                        label=user_name,
                        name="profile-name",
                    ),
                ],
            ),
        )
        github_button.connect(
            "clicked",
            lambda _: os.system(f"xdg-open https://github.com/{github_username}")
        )
        
        profile_box.children = [github_button]
        
        return Box(
            name="dashboard-header",
            orientation="v",
            spacing=8,
            children=[profile_box],
        )
    
    def create_team_selector(self):
        """Create team selector (Purple Team / Blue Team)"""
        selector_box = Box(
            name="team-selector",
            orientation="h",
            spacing=12,
            h_align="center",
        )
        
        # Purple Team button
        purple_button = Button(
            name="team-purple-btn",
            child=Label(label="💜 Purple Team"),
        )
        purple_button.connect("clicked", lambda _: self.switch_team("purple"))
        
        # Blue Team button
        blue_button = Button(
            name="team-blue-btn",
            child=Label(label="💙 Blue Team"),
        )
        blue_button.connect("clicked", lambda _: self.switch_team("blue"))
        
        selector_box.children = [purple_button, blue_button]
        
        return selector_box
    
    def switch_team(self, team):
        """Switch between purple and blue team"""
        self.config["team"] = team
        self.save_config()
        self.apply_team_theme()
    
    def apply_team_theme(self):
        """Apply team theme colors to dashboard"""
        team = self.config.get("team", "purple")
        
        if team == "purple":
            self.set_name("dashboard dashboard-purple")
        else:
            self.set_name("dashboard dashboard-blue")


def create_dashboard():
    """Create dashboard instance"""
    return Dashboard()
