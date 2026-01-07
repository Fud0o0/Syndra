"""
Icon utilities for SyndraShell
"""

# Icon names for various UI elements
ICONS = {
    "wallpaper": "wallpaper",
    "folder": "folder",
    "image": "image",
    "random": "media-playlist-shuffle",
    "search": "search",
    "screenshot": "camera-photo",
    "screen": "display",
    "window": "window",
    "region": "select-all",
    "record": "media-record",
    "stop": "media-playback-stop",
    "ocr": "text-x-generic",
    "color": "color-picker",
    "gamemode": "applications-games",
    "dashboard": "view-dashboard",
    "settings": "settings",
}


def get_icon(name: str) -> str:
    """Get icon name by key"""
    return ICONS.get(name, "image-missing")
