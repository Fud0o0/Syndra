# SyndraShell

> [!NOTE]
> You need a functioning Hyprland installation.
> This will also enable NetworkManager if it is not already enabled.

### Arch Linux

> [!TIP]
> This command also works for updating an existing installation!

**Run the following command in your terminal once logged into Hyprland:**
```bash
curl -fsSL get.axeni.de/ax-shell | bash
```

**Alternative:**
```bash
curl -fsSL https://raw.githubusercontent.com/Axenide/Ax-Shell/main/install.sh | bash
```

### NixOS
[poogas](https://github.com/poogas) has created a flake for Ax-Shell.
👉 [Try it out!](https://github.com/poogas/Ax-Shell) 👈

### Manual Installation
1. Install dependencies:
    - [Fabric](https://github.com/Fabric-Development/fabric)
    - [fabric-cli](https://github.com/Fabric-Development/fabric-cli)
    - [Gray](https://github.com/Fabric-Development/gray)
    - [Matugen](https://github.com/InioX/matugen)
    - `awww`
    - `brightnessctl`
    - `cava`
    - `cliphist`
    - `ddcutil`
    - `gnome-bluetooth-3.0`
    - `gobject-introspection`
    - `gpu-screen-recorder`
    - `grimblast`
    - `hypridle`
    - `hyprlock`
    - `hyprpicker`
    - `hyprshot`
    - `hyprsunset`
    - `imagemagick`
    - `libnotify`
    - `networkmanager`
    - `network-manager-applet`
    - `nm-connection-editor`
    - `noto-fonts-emoji`
    - `nvtop`
    - `playerctl`
    - `swappy`
    - `tesseract`
    - `tesseract-data-eng`
    - `tesseract-data-spa`
    - `tmux`
    - `unzip`
    - `upower`
    - `uwsm`
    - `vte3`
    - `webp-pixbuf-loader`
    - `wl-clipboard`
    - Python dependencies:
        - PyGObject
        - ijson
        - numpy
        - pillow
        - psutil
        - pywayland
        - requests
        - setproctitle
        - toml
        - watchdog
    - Fonts (automated on first run):
        - Zed Sans
        - Tabler Icons

2. Download and run Ax-Shell:
    ```bash
    git clone https://github.com/Axenide/Ax-Shell.git ~/.config/Ax-Shell
    uwsm -- app python ~/.config/Ax-Shell/main.py > /dev/null 2>&1 & disown
    ```

<h2><sub><img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Travel%20and%20places/Rocket.png" alt="Rocket" width="25" height="25" /></sub> Roadmap</h2>

- [x] App Launcher
- [x] Bluetooth Manager
- [x] Calculator
- [x] Calendar
- [x] Clipboard Manager
- [x] Color Picker
- [x] Customizable UI
- [x] Dashboard
- [x] Dock
- [x] Emoji Picker
- [x] Kanban Board
- [x] Network Manager
- [x] Notifications
- [x] OCR
- [x] Pins
- [x] Power Manager
- [x] Power Menu
- [x] Screen Recorder
- [x] Screenshot
- [x] Settings
- [x] System Tray
- [x] Terminal
- [x] Tmux Session Manager
- [x] Update checker
- [x] Vertical Layout
- [x] Wallpaper Selector
- [x] Workspaces Overview
- [x] Multi-monitor support
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
      <a href='https://ko-fi.com/Axenide' target='_blank'>
        <img style='border:0px;height:128px;'
             src='https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExc3N4NzlvZWs2Z2tsaGx4aHgwa3UzMWVpcmNwZTNraTM2NW84ZDlqbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/PaF9a1MpqDzovyqVKj/giphy.gif'
             border='0' alt='Support me on Ko-fi!' />
      </a>
    </td>
  </tr>
</table>
