#!/bin/bash
# Gamemode toggle script for SyndraShell

GAMEMODE_FILE="/tmp/syndrashell_gamemode"

if [ -f "$GAMEMODE_FILE" ]; then
    # Disable gamemode
    rm "$GAMEMODE_FILE"
    hyprctl --batch "\
        keyword animations:enabled true;\
        keyword decoration:blur:enabled true;\
        keyword decoration:drop_shadow true"
    notify-send -a "SyndraShell" "Game Mode Disabled" "Effects restored"
else
    # Enable gamemode
    touch "$GAMEMODE_FILE"
    hyprctl --batch "\
        keyword animations:enabled false;\
        keyword decoration:blur:enabled false;\
        keyword decoration:drop_shadow false"
    notify-send -a "SyndraShell" "Game Mode Enabled" "Effects disabled for better performance"
fi
