#!/bin/bash
# Screen recording script for SyndraShell

if [ -z "$XDG_VIDEOS_DIR" ]; then
    XDG_VIDEOS_DIR="$HOME/Videos"
fi

save_dir="${XDG_VIDEOS_DIR}/Recordings"
mkdir -p "$save_dir"

# Check if already recording
if pgrep -x "gpu-screen-reco" > /dev/null; then
    # Stop recording
    killall -SIGINT gpu-screen-recorder
    notify-send -a "SyndraShell" "Recording Stopped" "Saved to $save_dir"
else
    # Start recording
    save_file=$(date +'%y%m%d_%Hh%Mm%Ss_recording.mp4')
    full_path="$save_dir/$save_file"
    
    gpu-screen-recorder -w screen -f 60 -a "$(pactl get-default-sink).monitor" -o "$full_path" &
    
    notify-send -a "SyndraShell" "Recording Started" "Press SUPER+ALT+R to stop"
fi
