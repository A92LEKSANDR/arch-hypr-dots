#!/bin/bash

muted=$(pamixer --get-mute)
volume=$(pamixer --get-volume)
port=$(pactl list sinks | awk '/Active Port:/ {print $3}')

if [ "$muted" = "true" ]; then
    icon="🔇"
    text="$icon"
    tooltip="Muted"
    class="muted"
else
    if [[ "$port" == *"headphone"* ]]; then
        icon="🎧"
        class="headphones"
    else
        icon="📢"
        class="speakers"
    fi
    text="$icon$volume%"
    tooltip="Volume: $volume%"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
