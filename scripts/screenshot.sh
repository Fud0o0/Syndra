#!/bin/bash
# Screenshot script for SyndraShell

sleep 0.5

if [ -z "$XDG_PICTURES_DIR" ]; then
    XDG_PICTURES_DIR="$HOME/Pictures"
fi

save_dir="${3:-$XDG_PICTURES_DIR/Screenshots}"
save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
full_path="$save_dir/$save_file"
mkdir -p "$save_dir"

mockup_mode="$2"

print_error() {
    cat <<EOF
    ./screenshot.sh <action> [mockup]
    ...valid actions are...
        p  : print selected screen
        s  : snip selected region
        w  : snip focused window
EOF
}

case $1 in
    p)
        hyprshot -z -s -m output -o "$save_dir" -f "$save_file"
        ;;
    s)
        hyprshot -z -s -m region -o "$save_dir" -f "$save_file"
        ;;
    w)
        hyprshot -s -m window -o "$save_dir" -f "$save_file"
        ;;
    *)
        print_error
        exit 1
        ;;
esac

if [ -f "$full_path" ]; then
    # Copy to clipboard if not mockup
    if [ "$mockup_mode" != "mockup" ]; then
        if command -v wl-copy >/dev/null 2>&1; then
            wl-copy < "$full_path"
        elif command -v xclip >/dev/null 2>&1; then
            xclip -selection clipboard -t image/png < "$full_path"
        fi
    fi

    # Process mockup
    if [ "$mockup_mode" = "mockup" ]; then
        temp_file="${full_path%.png}_temp.png"
        mockup_file="${full_path%.png}_mockup.png"
        mockup_success=true

        # Round corners and transparency
        if [ "$mockup_success" = true ]; then
            magick "$full_path" \
                \( +clone -alpha extract -draw 'fill black polygon 0,0 0,20 20,0 fill white circle 20,20 20,0' \
                   \( +clone -flip \) -compose Multiply -composite \
                   \( +clone -flop \) -compose Multiply -composite \
                \) -alpha off -compose CopyOpacity -composite "$temp_file" || mockup_success=false
        fi

        # Add shadow
        if [ "$mockup_success" = true ]; then
            magick "$temp_file" \
                \( +clone -background black -shadow 60x20+0+10 -alpha set -channel A -evaluate multiply 1 +channel \) \
                +swap -background none -layers merge +repage "$mockup_file" || mockup_success=false
        fi

        if [ "$mockup_success" = true ] && [ -f "$mockup_file" ]; then
            rm "$temp_file"
            mv "$mockup_file" "$full_path"
            if command -v wl-copy >/dev/null 2>&1; then
                wl-copy < "$full_path"
            fi
            notify-send -a "SyndraShell" "Mockup Screenshot" "Saved to $save_dir" -i "$full_path"
        else
            notify-send -a "SyndraShell" "Mockup Failed" "Falling back to regular screenshot"
            if command -v wl-copy >/dev/null 2>&1; then
                wl-copy < "$full_path"
            fi
        fi
    else
        notify-send -a "SyndraShell" "Screenshot" "Saved to $save_dir" -i "$full_path"
    fi

    # Actions menu
    action=$(printf "edit\nopen" | wofi --dmenu --prompt "Screenshot action")
    case "$action" in
        edit) swappy -f "$full_path" ;;
        open) xdg-open "$save_dir" ;;
    esac
else
    notify-send -a "SyndraShell" "Screenshot Aborted"
fi
