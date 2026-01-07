# Changelog

All notable changes to SyndraShell will be documented in this file.

## [Unreleased]

### Added

- 📖 **Dependencies Documentation** - Complete dependency reference
  - `docs/DEPENDENCIES.md` - Detailed dependency list with links and usage info
  - Categorization by module and feature
  - Installation commands and package purposes
  - Dependency usage matrix

- 🔍 **Dependency Checker** - Automated dependency verification
  - `scripts/check-dependencies.sh` - Check installed dependencies
  - Categorizes missing packages (core, tools, optional)
  - Provides installation commands for missing packages

- 🖼️ **Wallpaper Selector Module** - Browse and set wallpapers with thumbnail preview
  - Thumbnail caching system (96x96 thumbnails)
  - Search/filter wallpapers by name
  - Random wallpaper selection
  - File monitoring (auto-updates on wallpaper add/remove)
  - Matugen integration for automatic color scheme generation
  - Current wallpaper tracking via symlink (`~/.current.wall`)

- 📸 **Screenshot System** - Complete screenshot toolkit
  - Multiple capture modes: Region, Window, Screen, Mockup
  - Automatic clipboard copy
  - Save to `~/Pictures/Screenshots/`
  - Desktop notifications
  - Action menu (edit with Swappy, open folder)
  - Mockup mode with rounded corners and shadows (ImageMagick)

- 🎬 **Screen Recording** - GPU-accelerated video capture
  - 60 FPS recording
  - System audio capture
  - Save to `~/Videos/Recordings/`
  - Toggle recording with simple keybind

- 📝 **OCR Tool** - Extract text from screen
  - Region selection
  - Tesseract OCR integration
  - Automatic clipboard copy
  - Desktop notifications

- 🎨 **Color Picker** - Pick colors from screen
  - Hyprpicker integration
  - Automatic clipboard copy (hex color code)

- ⚡ **Game Mode** - Performance optimization
  - Toggle all visual effects
  - Disables animations, blur, and shadows
  - Improves gaming performance

- 🛠️ **Toolbox Module** - Unified tools interface
  - All screenshot modes in one place
  - Screen recording controls
  - OCR launcher
  - Color picker launcher
  - Game mode toggle

- 📊 **Dashboard Module** - Centralized control panel
  - Tabbed interface (Wallpapers, Tools, Widgets)
  - Wallpaper selector integration
  - Toolbox integration
  - Widget placeholder for future expansions

- 📜 **Scripts** - Automation scripts
  - `screenshot.sh` - Screenshot capture with multiple modes
  - `screenrecord.sh` - Screen recording toggle
  - `ocr.sh` - OCR text extraction
  - `gamemode.sh` - Game mode toggle

- 📁 **Assets Structure**
  - `assets/wallpapers_example/` - Example wallpaper storage
  - `assets/screenshots/` - Project screenshot storage
  - `assets/fonts/` - Font downloads (auto-managed)

- 📖 **Documentation**
  - `docs/USAGE.md` - Complete usage guide
  - `config/hyprland/keybinds.conf` - Recommended Hyprland keybinds
  - `README.md` - Updated with new features

- ⚙️ **Configuration**
  - Wallpaper directory configuration
  - Screenshot directory configuration
  - Recording directory configuration

### Changed

- 📦 **Optimized Dependencies** - Cleaned up unused dependencies
  - Removed unused Python packages from active requirements
  - Moved `ijson`, `numpy`, `psutil`, `requests`, `toml` to "reserved" section
  - Updated `requirements.txt` with usage comments
  - Categorized install.sh packages (core, tools, optional)

- 📝 **Enhanced README** - Better dependency documentation
  - Added links to all dependencies
  - Categorized by purpose (Framework, Hyprland, Screenshots, etc.)
  - Marked optional vs required dependencies
  - Added link to detailed DEPENDENCIES.md
  - Separated actively used vs reserved Python packages

- Updated `install.sh` to include new dependencies:
  - hyprshot (screenshots)
  - hyprpicker (color picker)
  - gpu-screen-recorder (screen recording)
  - tesseract (OCR)
  - imagemagick (mockup screenshots)
  - swappy (screenshot editing)

- Updated `requirements.txt` with Python dependencies:
  - Pillow (image processing)
  - watchdog (file monitoring)

- Updated `README.md`:
  - Added screenshot/wallpaper features
  - Updated component descriptions
  - Added recommended keybinds
  - Updated installation dependencies

### Dependencies
- **Required:**
  - hyprshot
  - hyprpicker
  - wl-clipboard
  
- **Optional:**
  - gpu-screen-recorder (screen recording)
  - tesseract (OCR)
  - imagemagick (mockup mode)
  - swappy (screenshot editing)

## [1.0.0] - Initial Release

### Added
- Initial Fabric-based architecture
- Bar, Notch, Dock modules
- Brightness and Network services
- Configuration system
- Security with git-crypt
- Installation automation
