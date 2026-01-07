from fabric.widgets.box import Box
from fabric.widgets.stack import Stack
from fabric.widgets.label import Label
from gi.repository import Gtk

from widgets.wayland import WaylandWindow as Window
import config.data as data


class Notch(Window):
    """Dynamic notch/dropdown menu"""
    
    def __init__(self):
        self.stack = Stack(
            name="notch-stack",
            transition_type="slide-up-down",
            h_expand=True,
            v_expand=True,
        )
        
        # Add different notch views
        self.add_dashboard()
        self.add_launcher()
        
        super().__init__(
            layer="overlay",
            anchor="top",
            exclusive=False,
            visible=False,
            child=Box(
                name="notch-container",
                orientation="v",
                children=[self.stack],
            ),
        )
    
    def add_dashboard(self):
        """Add dashboard view"""
        dashboard = Box(
            name="dashboard",
            children=[
                Label(label="Dashboard", name="dashboard-title"),
            ],
        )
        self.stack.add_named(dashboard, "dashboard")
    
    def add_launcher(self):
        """Add app launcher view"""
        launcher = Box(
            name="launcher",
            children=[
                Label(label="App Launcher", name="launcher-title"),
            ],
        )
        self.stack.add_named(launcher, "launcher")
    
    def open_notch(self, view_name: str):
        """Open notch with specified view"""
        if self.stack.get_child_by_name(view_name):
            self.stack.set_visible_child_name(view_name)
            self.set_visible(True)
        else:
            print(f"View '{view_name}' not found in notch")
    
    def close_notch(self):
        """Close the notch"""
        self.set_visible(False)
