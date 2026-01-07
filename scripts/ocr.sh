#!/bin/bash
# OCR script for SyndraShell

# Take screenshot of region
temp_file="/tmp/ocr_screenshot.png"
hyprshot -z -s -m region -o /tmp -f "ocr_screenshot.png"

if [ -f "$temp_file" ]; then
    # Run OCR
    text=$(tesseract "$temp_file" - 2>/dev/null)
    
    if [ -n "$text" ]; then
        # Copy to clipboard
        echo "$text" | wl-copy
        notify-send -a "SyndraShell" "OCR Complete" "Text copied to clipboard"
    else
        notify-send -a "SyndraShell" "OCR Failed" "No text detected"
    fi
    
    # Cleanup
    rm "$temp_file"
else
    notify-send -a "SyndraShell" "OCR Aborted"
fi
