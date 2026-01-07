import os
import subprocess
from fabric.utils import exec_shell_command_async
from .data import APP_NAME, APP_NAME_CAP


def reload_hyprland():
    """Reload Hyprland configuration"""
    exec_shell_command_async("hyprctl reload")


def generate_hyprconf() -> str:
    """Generate Hyprland configuration for SyndraShell"""
    home = os.path.expanduser("~")
    
    return f"""# SyndraShell - Hyprland Configuration
exec-once = uwsm-app $(python {home}/.config/{APP_NAME_CAP}/main.py)

$fabricSend = fabric-cli exec {APP_NAME}

# SyndraShell keybinds
bind = SUPER, D, exec, $fabricSend 'notch.open_notch("dashboard")' # Dashboard
bind = SUPER, R, exec, $fabricSend 'notch.open_notch("launcher")' # App Launcher
bind = SUPER ALT, B, exec, killall {APP_NAME}; uwsm-app $(python {home}/.config/{APP_NAME_CAP}/main.py) # Reload SyndraShell

# Layer rules
layerrule = noanim, fabric

# Colors from matugen
source = {home}/.config/{APP_NAME_CAP}/config/hypr/colors.conf

general {{
    col.active_border = rgb($primary)
    col.inactive_border = rgb($surface)
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    layout = dwindle
}}

decoration {{
    blur {{
        enabled = yes
        size = 3
        passes = 3
    }}
    rounding = 10
    shadow {{
      enabled = true
      range = 10
      render_power = 2
    }}
}}

animations {{
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}}
"""


def ensure_hypr_config():
    """Ensure Hyprland config is generated"""
    hypr_config_dir = os.path.expanduser(f"~/.config/{APP_NAME_CAP}/config/hypr/")
    os.makedirs(hypr_config_dir, exist_ok=True)
    
    hypr_conf_path = os.path.join(hypr_config_dir, f"{APP_NAME}.conf")
    try:
        with open(hypr_conf_path, "w") as f:
            f.write(generate_hyprconf())
        print(f"Generated Hyprland config at {hypr_conf_path}")
    except Exception as e:
        print(f"Error generating Hypr config: {e}")
