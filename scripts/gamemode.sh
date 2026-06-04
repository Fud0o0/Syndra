#!/bin/bash
GAMEMODE_FILE="/tmp/syndrashell_gamemode"

# Mode check : juste retourner le statut sans toggler ni notifier
if [ "$1" = "check" ]; then
    [ -f "$GAMEMODE_FILE" ] && echo "t" || echo "f"
    exit 0
fi

# Mode toggle
if [ -f "$GAMEMODE_FILE" ]; then
    rm "$GAMEMODE_FILE"
    hyprctl --batch "\
        keyword animations:enabled true;\
        keyword decoration:blur:enabled true;\
        keyword decoration:drop_shadow true"
    notify-send -a "SyndraShell" "Game Mode Disabled" "Effects restored"
else
    touch "$GAMEMODE_FILE"
    hyprctl --batch "\
        keyword animations:enabled false;\
        keyword decoration:blur:enabled false;\
        keyword decoration:drop_shadow false"
    notify-send -a "SyndraShell" "Game Mode Enabled" "Effects disabled for better performance"
fi
