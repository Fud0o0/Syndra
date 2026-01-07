from fabric.widgets.box import Box
from fabric.widgets.button import Button
from fabric.widgets.image import Image
from fabric.widgets.label import Label
from gi.repository import Gtk

from widgets.wayland import WaylandWindow as Window
import config.data as data


class Dock(Window):
    """Application dock"""
    
    def __init__(self):
        self.apps_box = Box(
            name="dock-apps",
            spacing=8,
            orientation="h",
            children=self.create_app_buttons(),
        )
        
        super().__init__(
            layer="top",
            anchor="bottom left right",
            exclusive=True,
            visible=True,
            child=Box(
                name="dock-container",
                children=[self.apps_box],
            ),
        )
    
    def create_app_buttons(self):
        """Create app launcher buttons"""
        apps = [
            {"name": "Terminal", "icon": "", "cmd": data.DEFAULT_TERMINAL},
            {"name": "Browser", "icon": "󰈹", "cmd": data.DEFAULT_BROWSER},
            {"name": "Files", "icon": "", "cmd": data.DEFAULT_FILE_MANAGER},
        ]
        
        buttons = []
        for app in apps:
            btn = Button(
                name="dock-app",
                child=Label(label=app["icon"]),
                on_clicked=lambda *args, cmd=app["cmd"]: self.launch_app(cmd),
            )
            buttons.append(btn)
        
        return buttons
    
    def launch_app(self, command: str):
        """Launch an application"""
        import subprocess
        try:
            subprocess.Popen(command, shell=True)
        except Exception as e:
            print(f"Error launching app: {e}")
