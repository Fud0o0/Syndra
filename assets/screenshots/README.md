# Screenshots

Place screenshots of SyndraShell here for the README.

## Recommended Screenshots
1. Full desktop with bar, notch, and dock
2. Dashboard open
3. Wallpaper selector
4. App launcher
5. System metrics/widgets

## Tips
- Use high resolution (1920x1080 or higher)
- Show different themes/color schemes
- Highlight unique features
- Create mockups with rounded corners for professional look

## Create Mockup Screenshots
```bash
# Take screenshot and create mockup
bash scripts/screenshot.sh s mockup

# Or use ImageMagick directly
magick screenshot.png \
  \( +clone -alpha extract -draw 'fill black polygon 0,0 0,20 20,0 fill white circle 20,20 20,0' \
     \( +clone -flip \) -compose Multiply -composite \
     \( +clone -flop \) -compose Multiply -composite \
  \) -alpha off -compose CopyOpacity -composite rounded.png

magick rounded.png \
  \( +clone -background black -shadow 60x20+0+10 \) \
  +swap -background none -layers merge +repage mockup.png
```
