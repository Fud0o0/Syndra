import json
import os

import gi

gi.require_version("Gtk", "3.0")
from fabric.utils.helpers import get_relative_path
from gi.repository import Gdk, GLib

APP_NAME_CAP = "SyndraShell"
APP_NAME = "syndrashell"

CACHE_DIR = str(GLib.get_user_cache_dir()) + f"/{APP_NAME}"

USERNAME = os.getlogin()
HOSTNAME = os.uname().nodename
HOME_DIR = os.path.expanduser("~")

CONFIG_DIR = os.path.expanduser(f"~/.config/{APP_NAME_CAP}")

screen = Gdk.Screen.get_default()
CURRENT_WIDTH = screen.get_width()
CURRENT_HEIGHT = screen.get_height()

CONFIG_FILE = get_relative_path("../config/config.json")


def load_config():
    """Load the configuration from config.json"""
    try:
        with open(CONFIG_FILE, "r") as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"Config file not found: {CONFIG_FILE}")
        return {}
    except json.JSONDecodeError as e:
        print(f"Error parsing config file: {e}")
        return {}


# Default configuration values
DEFAULTS = {
    "bar_position": "Top",
    "dock_position": "Bottom",
    "theme": "catppuccin",
    "animations": True,
    "blur": True,
    "terminal": "kitty",
    "launcher": "wofi",
    "file_manager": "thunar",
    "browser": "firefox",
}

# Load configuration
config = {}
if os.path.exists(CONFIG_FILE):
    try:
        with open(CONFIG_FILE, "r") as f:
            config = json.load(f)
    except Exception as e:
        print(f"Error loading config: {e}")
        config = {}


def get_default(key: str, default=None):
    """Get a configuration value with fallback to default"""
    return config.get(key, DEFAULTS.get(key, default))


# Configuration shortcuts
BAR_POSITION = get_default("bar_position", "Top")
DOCK_POSITION = get_default("dock_position", "Bottom")
THEME = get_default("theme", "catppuccin")
ANIMATIONS_ENABLED = get_default("animations", True)
BLUR_ENABLED = get_default("blur", True)

# App defaults
DEFAULT_TERMINAL = get_default("terminal", "kitty")
DEFAULT_LAUNCHER = get_default("launcher", "wofi")
DEFAULT_FILE_MANAGER = get_default("file_manager", "thunar")
DEFAULT_BROWSER = get_default("browser", "firefox")
