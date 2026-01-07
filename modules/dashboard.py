"""
Dashboard module for SyndraShell
Displays wallpaper selector, tools, and system information
"""
from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.notebook import Notebook
from gi.repository import Gtk

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
        
        # Header
        header = Label(
            name="dashboard-header",
            label="SyndraShell Dashboard",
            h_expand=True,
        )
        
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
        self.children = [header, self.notebook]


def create_dashboard():
    """Create dashboard instance"""
    return Dashboard()
