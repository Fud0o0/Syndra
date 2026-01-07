"""
Icon resolver utility for SyndraShell
Resolves application icons from various sources
"""
from gi.repository import Gtk, Gio
import os


class IconResolver:
    """Resolve application icons"""
    
    def __init__(self):
        self.icon_theme = Gtk.IconTheme.get_default()
        self.fallback_icon = "application-x-executable"
    
    def get_icon_name(self, app_id: str, fallback: str = None) -> str:
        """
        Get icon name for an application
        
        Args:
            app_id: Application ID or desktop entry name
            fallback: Fallback icon name if not found
            
        Returns:
            Icon name as string
        """
        if not app_id:
            return fallback or self.fallback_icon
        
        # Try direct lookup
        if self.icon_theme.has_icon(app_id):
            return app_id
        
        # Try with lowercase
        app_id_lower = app_id.lower()
        if self.icon_theme.has_icon(app_id_lower):
            return app_id_lower
        
        # Try common variations
        variations = [
            app_id.replace("-", "."),
            app_id.replace("_", "-"),
            app_id.split(".")[-1] if "." in app_id else app_id,
        ]
        
        for variant in variations:
            if self.icon_theme.has_icon(variant):
                return variant
        
        return fallback or self.fallback_icon
    
    def get_icon_path(self, icon_name: str, size: int = 48) -> str:
        """
        Get full path to icon file
        
        Args:
            icon_name: Icon name
            size: Icon size in pixels
            
        Returns:
            Full path to icon file
        """
        icon_info = self.icon_theme.lookup_icon(icon_name, size, 0)
        if icon_info:
            return icon_info.get_filename()
        return None
