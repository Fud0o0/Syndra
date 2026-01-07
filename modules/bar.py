from fabric.widgets.box import Box
from fabric.widgets.button import Button
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.datetime import DateTime
from fabric.widgets.label import Label
from gi.repository import Gtk

import config.data as data
from widgets.wayland import WaylandWindow as Window


class Bar(Window):
    """Main status bar"""
    
    def __init__(self):
        self.bar_box = CenterBox(
            name="bar-container",
            start_children=self.create_left_widgets(),
            center_children=self.create_center_widgets(),
            end_children=self.create_right_widgets(),
        )
        
        super().__init__(
            layer="top",
            anchor="top left right",
            exclusive=True,
            visible=True,
            all_visible=True,
            child=self.bar_box,
        )
    
    def create_left_widgets(self):
        """Create left side widgets"""
        return Box(
            spacing=8,
            children=[
                Label(
                    label="󰣇",  # SyndraShell icon
                    name="shell-logo",
                ),
            ],
        )
    
    def create_center_widgets(self):
        """Create center widgets"""
        return Box(
            spacing=8,
            children=[
                DateTime(
                    format_list=["%H:%M"],
                    name="clock",
                ),
            ],
        )
    
    def create_right_widgets(self):
        """Create right side widgets"""
        return Box(
            spacing=8,
            children=[
                Label(
                    label=f"{data.USERNAME}@{data.HOSTNAME}",
                    name="user-info",
                ),
            ],
        )
