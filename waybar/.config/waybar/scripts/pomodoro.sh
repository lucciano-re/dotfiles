#!/usr/bin/env bash

# Path to your custom end sound
SOUND_FILE="$HOME/.config/waybar/sounds/complete.wav"

STATE_FILE="/tmp/waybar_pomodoro_state"
CONFIG_FILE="/tmp/waybar_pomodoro_config"

# Default times (in seconds)
DEFAULT_WORK=2400  # 40 mins
DEFAULT_BREAK=600   # 10 mins

# Load user configuration or set defaults
if [ -f "$CONFIG_FILE" ]; then
    read -r WORK_TIME BREAK_TIME < "$CONFIG_FILE"
else
    WORK_TIME=$DEFAULT_WORK
    BREAK_TIME=$DEFAULT_BREAK
fi

get_state() {
    if [ ! -f "$STATE_FILE" ]; then
        echo "stopped 0 0" > "$STATE_FILE"
    fi
    cat "$STATE_FILE"
}

update_state() {
    echo "$1 $2 $3" > "$STATE_FILE"
}

notify() {
    if command -v notify-send &>/dev/null; then
        notify-send -u normal -a "Pomodoro" "$1" "$2"
    fi
    if [ -f "$SOUND_FILE" ]; then
        aplay "$SOUND_FILE" &>/dev/null & 
    fi
}

format_time() {
    local seconds=$1
    printf "%02d:%02d" $((seconds / 60)) $((seconds % 60))
}

# Read current state
read -r state duration remaining < <(get_state)

# Handle actions
case "$1" in
    toggle)
        # Left click: Cycle states immediately without pausing
        if [ "$state" == "stopped" ] || [ "$state" == "break" ]; then
            update_state "work" "$WORK_TIME" "$WORK_TIME"
        else
            update_state "break" "$BREAK_TIME" "$BREAK_TIME"
        fi
        exit 0
        ;;
    stop)
        # Right click: Kill the timer
        update_state "stopped" "0" "0"
        exit 0
        ;;
    config)
        # Middle click: UI Config Menu
        if command -v zenity &>/dev/null; then
            res=$(zenity --forms --title="Pomodoro Settings" --text="Set times in minutes" \
                --add-entry="Work Duration" --add-entry="Break Duration" 2>/dev/null)
            if [ -n "$res" ]; then
                w_min=$(echo "$res" | cut -d'|' -f1)
                b_min=$(echo "$res" | cut -d'|' -f2)
                
                # Fallback to defaults if inputs are empty or invalid integers
                [[ "$w_min" =~ ^[0-9]+$ ]] && new_work=$((w_min * 60)) || new_work=$DEFAULT_WORK
                [[ "$b_min" =~ ^[0-9]+$ ]] && new_break=$((b_min * 60)) || new_break=$DEFAULT_BREAK
                
                echo "$new_work $new_break" > "$CONFIG_FILE"
                
                # If stopped, seamlessly apply updates
                if [ "$state" == "stopped" ]; then
                    update_state "stopped" "0" "0"
                fi
            fi
        fi
        exit 0
        ;;
esac

# Timer Tick Logic (Auto-continues)
if [ "$state" != "stopped" ]; then
    ((remaining--))
    if [ "$remaining" -le 0 ]; then
        if [ "$state" == "work" ]; then
            notify "Focus Done!" "Switching automatically to break."
            update_state "break" "$BREAK_TIME" "$BREAK_TIME"
        else
            notify "Break Done!" "Switching automatically back to work."
            update_state "work" "$WORK_TIME" "$WORK_TIME"
        fi
    else
        update_state "$state" "$duration" "$remaining"
    fi
fi

# Output JSON for Waybar
time_str=$(format_time "$remaining")

if [ "$state" == "work" ]; then
    echo "{\"text\": \"󱎫 $time_str\", \"class\": \"work\", \"tooltip\": \"Focusing...\"}"
elif [ "$state" == "break" ]; then
    echo "{\"text\": \"󰒲 $time_str\", \"class\": \"break\", \"tooltip\": \"On a Break\"}"
else
    echo "{\"text\": \"󱎭\", \"class\": \"stopped\", \"tooltip\": \"L-Click: Start\\nR-Click: Stop\\nM-Click: Settings\"}"
fi
