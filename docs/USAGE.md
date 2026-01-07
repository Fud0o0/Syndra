# Usage Guide - Screenshots & Wallpapers

## Screenshots

### Taking Screenshots

SyndraShell includes a powerful screenshot system with multiple capture modes:

#### Via Keybinds (recommended)
Add these to your `~/.config/hypr/hyprland.conf`:
```bash
bind = SUPER SHIFT, S, exec, bash ~/.config/SyndraShell/scripts/screenshot.sh s
bind = SUPER SHIFT, W, exec, bash ~/.config/SyndraShell/scripts/screenshot.sh w
bind = SUPER SHIFT, P, exec, bash ~/.config/SyndraShell/scripts/screenshot.sh p
bind = SUPER SHIFT, M, exec, bash ~/.config/SyndraShell/scripts/screenshot.sh s mockup
```

#### Via Dashboard
1. Open Dashboard (`SUPER + D`)
2. Navigate to **Tools** tab
3. Click the screenshot button:
   - **✂️ Region** - Select area to capture
   - **🪟 Window** - Capture focused window
   - **🖥️ Screen** - Capture entire screen
   - **🎨 Mockup** - Capture with rounded corners and shadow

#### Via Terminal
```bash
# Region screenshot
bash ~/.config/SyndraShell/scripts/screenshot.sh s

# Window screenshot
bash ~/.config/SyndraShell/scripts/screenshot.sh w

# Screen screenshot
bash ~/.config/SyndraShell/scripts/screenshot.sh p

# Mockup screenshot (region with effects)
bash ~/.config/SyndraShell/scripts/screenshot.sh s mockup
```

### Screenshot Features

- **Automatic clipboard copy** - Screenshots are automatically copied to clipboard
- **Save to Pictures/Screenshots** - Screenshots are saved to `~/Pictures/Screenshots/`
- **Notification** - Desktop notification when screenshot is taken
- **Action menu** - Choose to edit (Swappy) or open folder after capture
- **Mockup mode** - Rounded corners + shadow for professional screenshots

### Screenshot Requirements

- `hyprshot` - Screenshot tool for Hyprland
- `wl-clipboard` - Clipboard support
- `swappy` (optional) - Screenshot editing
- `imagemagick` (optional) - Mockup mode effects
- `wofi` - Action menu

---

## Wallpapers

### Setting Wallpapers

#### Via Dashboard (GUI)
1. Open Dashboard (`SUPER + D`)
2. Navigate to **Wallpaper Selector** tab
3. Browse thumbnails or use search
4. Click wallpaper to apply
5. Click **🎲 Random** for random wallpaper

#### Via Terminal
```bash
# Random wallpaper
python -c "from modules.wallpapers import WallpaperSelector; WallpaperSelector().set_random_wallpaper(external=True)"
```

### Wallpaper Features

- **Thumbnail preview** - Fast thumbnail caching (96x96)
- **Search** - Filter wallpapers by name
- **Random selection** - Pick random wallpaper
- **File monitoring** - Auto-updates when wallpapers are added/removed
- **Matugen integration** - Automatic color scheme generation
- **Symlink tracking** - Current wallpaper at `~/.current.wall`

### Adding Wallpapers

1. Copy images to wallpaper directory:
   ```bash
   cp /path/to/wallpaper.jpg ~/Pictures/Wallpapers/
   ```

2. Wallpapers will appear automatically in the selector

3. Supported formats: PNG, JPG, JPEG, BMP, GIF, WebP

### Configuring Wallpaper Directory

Edit `~/.config/SyndraShell/config.json`:
```json
{
  "wallpapers_dir": "~/Pictures/Wallpapers"
}
```

### Example Wallpapers

Example wallpapers are located in:
```
~/.config/SyndraShell/assets/wallpapers_example/
```

Copy these to your wallpaper directory to get started:
```bash
cp ~/.config/SyndraShell/assets/wallpapers_example/* ~/Pictures/Wallpapers/
```

---

## Screen Recording

### Start/Stop Recording

#### Via Keybind
```bash
bind = SUPER ALT, R, exec, bash ~/.config/SyndraShell/scripts/screenrecord.sh
```

#### Via Dashboard
1. Open Dashboard (`SUPER + D`)
2. Navigate to **Tools** tab
3. Click **⏺️ Record** to start
4. Click **⏹️ Stop** to end recording

### Recording Features

- **60 FPS** - Smooth video capture
- **Audio recording** - Captures system audio
- **Save to Videos/Recordings** - Videos saved to `~/Videos/Recordings/`
- **GPU acceleration** - Uses gpu-screen-recorder

### Recording Requirements

- `gpu-screen-recorder` - GPU-accelerated screen recording
- `pulseaudio` or `pipewire` - Audio support

---

## OCR (Text Extraction)

### Extract Text from Screen

#### Via Keybind
```bash
bind = SUPER ALT, O, exec, bash ~/.config/SyndraShell/scripts/ocr.sh
```

#### Via Dashboard
1. Open Dashboard (`SUPER + D`)
2. Navigate to **Tools** tab
3. Click **🔍 Extract Text**
4. Select region with text
5. Text is copied to clipboard

### OCR Requirements

- `tesseract` - OCR engine
- `hyprshot` - Screenshot capture
- `wl-clipboard` - Clipboard support

---

## Color Picker

### Pick Color from Screen

#### Via Keybind
```bash
bind = SUPER ALT, C, exec, hyprpicker -a
```

#### Via Dashboard
1. Open Dashboard (`SUPER + D`)
2. Navigate to **Tools** tab
3. Click **🎯 Pick Color**
4. Click anywhere on screen
5. Color code copied to clipboard

### Color Picker Requirements

- `hyprpicker` - Wayland color picker

---

## Game Mode

### Toggle Performance Mode

Game mode disables visual effects for better gaming performance.

#### Via Keybind
```bash
bind = SUPER ALT, G, exec, bash ~/.config/SyndraShell/scripts/gamemode.sh
```

#### Via Dashboard
1. Open Dashboard (`SUPER + D`)
2. Navigate to **Tools** tab
3. Click **⚡ Game Mode**

### Game Mode Effects

When enabled:
- ❌ Animations disabled
- ❌ Blur disabled
- ❌ Drop shadows disabled

When disabled:
- ✅ All effects restored

---

## Tips & Tricks

### Create Professional Screenshots

Use mockup mode for README/portfolio screenshots:
```bash
bash ~/.config/SyndraShell/scripts/screenshot.sh s mockup
```

This creates screenshots with:
- Rounded corners (20px radius)
- Drop shadow (60x20+0+10)
- Transparent background

### Batch Process Wallpapers

Rename all wallpapers to lowercase with hyphens:
```bash
cd ~/Pictures/Wallpapers
for file in *; do
  newname=$(echo "$file" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  mv "$file" "$newname"
done
```

### Random Wallpaper on Login

Add to `~/.config/hypr/hyprland.conf`:
```bash
exec-once = python -c "from modules.wallpapers import WallpaperSelector; WallpaperSelector().set_random_wallpaper()"
```

### Custom Screenshot Directory

Edit `scripts/screenshot.sh` line 7:
```bash
save_dir="${3:-$HOME/Pictures/MyScreenshots}"
```

---

## Troubleshooting

### Screenshots not working
1. Check if hyprshot is installed: `which hyprshot`
2. Check if wl-clipboard is installed: `which wl-copy`
3. Check script permissions: `chmod +x ~/.config/SyndraShell/scripts/screenshot.sh`

### Wallpapers not appearing
1. Check wallpaper directory exists: `ls ~/Pictures/Wallpapers`
2. Check file formats (must be image files)
3. Check file permissions

### Mockup mode failing
1. Install ImageMagick: `sudo pacman -S imagemagick`
2. Check script can find magick: `which magick`

### OCR not working
1. Install Tesseract: `sudo pacman -S tesseract tesseract-data-eng`
2. Check language data: `ls /usr/share/tessdata/`

### Recording no audio
1. Check default sink: `pactl get-default-sink`
2. Test audio: `pactl play-sample bell`
3. Check PulseAudio/Pipewire running: `pactl info`
