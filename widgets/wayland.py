"""
Wayland Window wrapper for Fabric
"""
from fabric.widgets.window import Window as FabricWindow
from gi.repository import Gtk


class WaylandWindow(FabricWindow):
    """Extended window class for Wayland"""
    
    def __init__(
        self,
        layer: str = "top",
        anchor: str = "",
        exclusive: bool = False,
        **kwargs
    ):
        super().__init__(**kwargs)
        
        # Set layer shell properties if available
        try:
            from gi.repository import GtkLayerShell
            
            GtkLayerShell.init_for_window(self)
            
            # Set layer
            if layer == "background":
                GtkLayerShell.set_layer(self, GtkLayerShell.Layer.BACKGROUND)
            elif layer == "bottom":
                GtkLayerShell.set_layer(self, GtkLayerShell.Layer.BOTTOM)
            elif layer == "top":
                GtkLayerShell.set_layer(self, GtkLayerShell.Layer.TOP)
            elif layer == "overlay":
                GtkLayerShell.set_layer(self, GtkLayerShell.Layer.OVERLAY)
            
            # Set anchors
            if anchor:
                for edge in anchor.split():
                    if edge == "top":
                        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
                    elif edge == "bottom":
                        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.BOTTOM, True)
                    elif edge == "left":
                        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.LEFT, True)
                    elif edge == "right":
                        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, True)
            
            # Set exclusive zone
            GtkLayerShell.auto_exclusive_zone_enable(self) if exclusive else None
            
        except ImportError:
            print("GtkLayerShell not available, running in X11 mode")
