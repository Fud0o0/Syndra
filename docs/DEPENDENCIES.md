# Dependencies Reference

Complete list of SyndraShell dependencies with usage information.

## System Dependencies

### Core Framework (REQUIRED)

| Package | Purpose | Link | Used In |
|---------|---------|------|---------|
| `python-fabric-git` | Main GTK3 framework for Wayland | [GitHub](https://github.com/Fabric-Development/fabric) | All modules, widgets |
| `fabric-cli-git` | CLI tools for Fabric development | [GitHub](https://github.com/Fabric-Development/fabric-cli) | Development |
| `matugen-bin` | Material Design color scheme generator | [GitHub](https://github.com/InioX/matugen) | `modules/wallpapers.py` |
| `python-gobject` | Python bindings for GTK3/GObject | [GNOME](https://gitlab.gnome.org/GNOME/pygobject) | All GTK components |
| `python-pywayland` | Python bindings for Wayland protocols | [PyPI](https://pypi.org/project/pywayland/) | `scripts/inhibit.py` |

### Hyprland Ecosystem (REQUIRED)

| Package | Purpose | Link | Used In |
|---------|---------|------|---------|
| `hyprland` | Dynamic tiling Wayland compositor | [GitHub](https://github.com/hyprwm/Hyprland) | Core compositor |
| `hypridle` | Idle daemon for Hyprland | [GitHub](https://github.com/hyprwm/hypridle) | Screen idle management |
| `hyprlock` | Screen locker for Hyprland | [GitHub](https://github.com/hyprwm/hyprlock) | Screen locking |
| `hyprshot` | Screenshot utility for Hyprland | [GitHub](https://github.com/Gustash/Hyprshot) | `scripts/screenshot.sh` |
| `hyprpicker` | Color picker for Hyprland | [GitHub](https://github.com/hyprwm/hyprpicker) | `modules/tools.py` |

### Screenshot & Media Tools (REQUIRED)

| Package | Purpose | Link | Used In |
|---------|---------|------|---------|
| `imagemagick` | Image manipulation (mockup effects) | [Website](https://imagemagick.org/) | `scripts/screenshot.sh` (mockup mode) |
| `wl-clipboard` | Wayland clipboard utilities | [GitHub](https://github.com/bugaevc/wl-clipboard) | All screenshot/OCR scripts |

### System Utilities (REQUIRED)

| Package | Purpose | Link | Used In |
|---------|---------|------|---------|
| `brightnessctl` | Brightness control | [GitHub](https://github.com/Hummer12007/brightnessctl) | `services/brightness.py` |
| `networkmanager` | Network management daemon | [GNOME](https://wiki.gnome.org/Projects/NetworkManager) | `services/network.py` |
| `kitty` | GPU-accelerated terminal emulator | [Website](https://sw.kovidgoyal.net/kitty/) | Default terminal |
| `wofi` | Wayland application launcher | [Sourcehut](https://hg.sr.ht/~scoopta/wofi) | App launcher, action menus |

### Optional Features

| Package | Purpose | Link | Used In | Notes |
|---------|---------|------|---------|-------|
| `waybar` | Wayland status bar | [GitHub](https://github.com/Alexays/Waybar) | N/A | Alternative bar (not used by default) |
| `dunst` | Notification daemon | [Website](https://dunst-project.org/) | N/A | Alternative notifications (not used by default) |
| `network-manager-applet` | NetworkManager GUI | [GNOME](https://gitlab.gnome.org/GNOME/network-manager-applet) | System tray | Optional GUI |
| `playerctl` | Media player control | [GitHub](https://github.com/altdesktop/playerctl) | Future feature | Reserved for media widget |
| `cliphist` | Clipboard history manager | [GitHub](https://github.com/sentriz/cliphist) | Future feature | Reserved for clipboard widget |
| `gpu-screen-recorder` | GPU-accelerated screen recording | [Codeberg](https://git.dec05eba.com/gpu-screen-recorder/about/) | `scripts/screenrecord.sh` | Optional (screen recording) |
| `tesseract` | OCR engine | [GitHub](https://github.com/tesseract-ocr/tesseract) | `scripts/ocr.sh` | Optional (text extraction) |
| `swappy` | Screenshot editor | [GitHub](https://github.com/jtheoof/swappy) | Screenshot workflow | Optional (edit screenshots) |

---

## Python Dependencies

### Python Dependencies

| Package | Used In |
|---------|---------|
| [PyGObject](https://pypi.org/project/PyGObject/) | All modules, widgets, services |
| [Pillow](https://pypi.org/project/Pillow/) | `modules/wallpapers.py` |
| [pywayland](https://pypi.org/project/pywayland/) | `scripts/inhibit.py` |
| [setproctitle](https://pypi.org/project/setproctitle/) | `main.py`, `scripts/inhibit.py` |
| [watchdog](https://pypi.org/project/watchdog/) | `modules/wallpapers.py` |
| [loguru](https://pypi.org/project/loguru/) | Future logging |

---

## Fonts (Auto-downloaded)

| Font | Purpose | Source |
|------|---------|--------|
| Zed Sans | UI font (labels, buttons) | [GitHub](https://github.com/zed-industries/zed-fonts) |
| JetBrainsMono Nerd Font | Monospace font with icons | [Nerd Fonts](https://www.nerdfonts.com/) |
| Tabler Icons | Icon font | [Tabler Icons](https://tabler-icons.io/) |

---

## Dependency Installation

### Arch Linux (Automated)

```bash
curl -fsSL https://raw.githubusercontent.com/Fud0o0/SyndraShell/main/install.sh | bash
```

### Manual Installation

```bash
# Core + Required
yay -S python-fabric-git fabric-cli-git matugen-bin hyprland hypridle hyprlock \
       brightnessctl networkmanager python-gobject python-pywayland wl-clipboard \
       kitty wofi hyprshot hyprpicker imagemagick

# Optional
yay -S waybar dunst network-manager-applet playerctl cliphist \
       gpu-screen-recorder tesseract swappy

# Python
pip install --user -r requirements.txt
```

---

## Dependency Usage Matrix

### By Module

| Module | Dependencies |
|--------|--------------|
| `modules/wallpapers.py` | Pillow, watchdog, matugen, PyGObject |
| `modules/tools.py` | hyprshot, hyprpicker, gpu-screen-recorder, tesseract |
| `modules/bar.py` | PyGObject, Fabric |
| `modules/dock.py` | PyGObject, Fabric |
| `modules/notch.py` | PyGObject, Fabric |
| `modules/dashboard.py` | PyGObject, Fabric |
| `services/brightness.py` | brightnessctl |
| `services/network.py` | NetworkManager |
| `scripts/inhibit.py` | pywayland, setproctitle |
| `scripts/screenshot.sh` | hyprshot, imagemagick, wl-clipboard, wofi, swappy |
| `scripts/screenrecord.sh` | gpu-screen-recorder |
| `scripts/ocr.sh` | tesseract, hyprshot, wl-clipboard |
| `scripts/gamemode.sh` | hyprctl (part of Hyprland) |

### By Feature

| Feature | Required | Optional |
|---------|----------|----------|
| **Core Shell** | python-fabric-git, PyGObject, hyprland | - |
| **Wallpaper Selector** | Pillow, watchdog, matugen | - |
| **Screenshots** | hyprshot, imagemagick, wl-clipboard | swappy |
| **Screen Recording** | - | gpu-screen-recorder |
| **OCR** | - | tesseract |
| **Color Picker** | hyprpicker, wl-clipboard | - |
| **Brightness Control** | brightnessctl | - |
| **Network Management** | NetworkManager | network-manager-applet |
| **Idle Management** | hypridle, hyprlock, pywayland | - |

---

## Notes

- **Required** dependencies are essential for core functionality
- **Optional** dependencies enable additional features
- **Reserved** Python packages are in requirements.txt but not yet used
- All fonts are automatically downloaded on first run
- `waybar` and `dunst` are included for compatibility but not used by default (SyndraShell uses Fabric-based components)
