# SyndraShell

> [!NOTE]
> You need a functioning Hyprland installation.
> Built with Fabric framework - inspired by Ax-Shell.

> [!TIP]
> 📖 For a complete dependency reference with links and usage details, see [DEPENDENCIES.md](docs/DEPENDENCIES.md)

### Arch Linux

> [!TIP]
> This command also works for updating an existing installation!

**Run the following command in your terminal once logged into Hyprland:**
```bash
curl -fsSL https://raw.githubusercontent.com/Fud0o0/SyndraShell/main/install.sh | bash
```

### Manual Installation

#### System Dependencies

**Core Framework:**
- [Fabric](https://github.com/Fabric-Development/fabric)
- [fabric-cli](https://github.com/Fabric-Development/fabric-cli)
- [Matugen](https://github.com/InioX/matugen)

**Hyprland & Wayland:**
- [Hyprland](https://github.com/hyprwm/Hyprland)
- [hypridle](https://github.com/hyprwm/hypridle)
- [hyprlock](https://github.com/hyprwm/hyprlock)
- [hyprshot](https://github.com/Gustash/Hyprshot)
- [hyprpicker](https://github.com/hyprwm/hyprpicker)
- [swww](https://github.com/LGFae/swww)
- [swaybg](https://github.com/swaywm/swaybg)

**Screenshot & Recording:**
- [gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/)
- [tesseract](https://github.com/tesseract-ocr/tesseract)
- [ImageMagick](https://imagemagick.org/)
- [swappy](https://github.com/jtheoof/swappy)

**System Utilities:**
- `brightnessctl`
- `networkmanager`
- `network-manager-applet`
- `playerctl`
- `wl-clipboard`
- `cliphist`

**Terminals & UI:**
- [kitty](https://sw.kovidgoyal.net/kitty/)
- [wofi](https://hg.sr.ht/~scoopta/wofi)
- [waybar](https://github.com/Alexays/Waybar)
- [dunst](https://dunst-project.org/)

#### Python Dependencies

- [PyGObject](https://pypi.org/project/PyGObject/)
- [Pillow](https://pypi.org/project/Pillow/)
- [pywayland](https://pypi.org/project/pywayland/)
- [setproctitle](https://pypi.org/project/setproctitle/)
- [watchdog](https://pypi.org/project/watchdog/)
- [loguru](https://pypi.org/project/loguru/)

#### Fonts (Auto-downloaded on first run)

- [Zed Sans](https://github.com/zed-industries/zed-fonts)
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)
- [Tabler Icons](https://tabler-icons.io/)

2. Download and run SyndraShell:
    ```bash
    git clone https://github.com/Fud0o0/SyndraShell.git ~/.config/SyndraShell
    cd ~/.config/SyndraShell
    pip install --user -r requirements.txt
    uwsm app -- python ~/.config/SyndraShell/main.py > /dev/null 2>&1 & disown
    ```

## Components

- **Bar**
- **Dock**
- **Notch**
- **Dashboard**

## Keybinds

### General
- `SUPER + D` - Open Dashboard
- `SUPER + R` - App Launcher
- `SUPER + L` - Lock session
- `SUPER + ALT + B` - Reload SyndraShell

### Window Management
- `SUPER + Q` or `ALT + F4` - Close window

### Screenshots (recommended bindings)
- `SUPER + SHIFT + S` - Screenshot region
- `SUPER + SHIFT + W` - Screenshot window
- `SUPER + SHIFT + P` - Screenshot screen
- `SUPER + SHIFT + M` - Screenshot region (mockup mode)

### Tools
- `SUPER + ALT + R` - Toggle screen recording
- `SUPER + ALT + O` - OCR (extract text from screen)
- `SUPER + ALT + C` - Color picker
- `SUPER + ALT + G` - Toggle game mode

## Credits

Inspired by [Ax-Shell](https://github.com/Axenide/Ax-Shell) by Axenide.
Built with [Fabric](https://github.com/Fabric-Development/fabric).



<h2><sub><img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Travel%20and%20places/Rocket.png" alt="Rocket" width="25" height="25" /></sub> Roadmap</h2>

- [ ] App Launcher
- [ ] Bluetooth Manager
- [ ] Calculator
- [ ] Calendar
- [ ] Clipboard Manager
- [ ] Color Picker
- [ ] Customizable UI
- [ ] Dashboard
- [ ] Dock
- [ ] Emoji Picker
- [ ] Kanban Board
- [ ] Network Manager
- [ ] Notifications
- [ ] OCR
- [ ] Pins
- [ ] Power Manager
- [ ] Power Menu
- [ ] Screen Recorder
- [ ] Screenshot
- [ ] Settings
- [ ] System Tray
- [ ] Terminal
- [ ] Tmux Session Manager
- [ ] Update checker
- [ ] Vertical Layout
- [ ] Wallpaper Selector
- [ ] Workspaces Overview
- [ ] Multi-monitor support
- [ ] Multimodal AI Assistant
- [ ] OSD
- [ ] OTP Manager

---

<table align="center">
  <tr>
    <td align="center"><img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Telegram-Animated-Emojis/main/Activity/Sparkles.webp" alt="Sparkles" width="16" height="16" /><sup> sᴜᴘᴘᴏʀᴛ ᴛʜᴇ ᴘʀᴏᴊᴇᴄᴛ </sup><img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Telegram-Animated-Emojis/main/Activity/Sparkles.webp" alt="Sparkles" width="16" height="16" /></td>
  </tr>
  <tr>
    <td align="center">
      <a href='https://ko-fi.com/syndrashell' target='_blank'>
        <img style='border:0px;height:128px;'
             src='https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExc3N4NzlvZWs2Z2tsaGx4aHgwa3UzMWVpcmNwZTNraTM2NW84ZDlqbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/PaF9a1MpqDzovyqVKj/giphy.gif'
             border='0' alt='Support me on Ko-fi!' />
      </a>
    </td>
  </tr>
</table>












