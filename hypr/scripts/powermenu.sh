#!/bin/bash

hibernate() {
  if [[ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ]]; then
    notify-send "Hibernate" "Battery is low! Plug in the charger." -u critical
  else
    systemctl hibernate
  fi
}

options=(
  "🔒 Lock::gtklock"
  "⏻ Shutdown::systemctl poweroff"
  "🔁 Reboot::systemctl reboot"
  "🚪 Logout::hyprctl dispatch exit"
  "💤 Suspend::systemctl suspend"
  "🌙 Hibernate::hibernate"
)

chosen=$(printf "%s\n" "${options[@]}" | cut -d ":" -f 1 | wofi --dmenu -p "Power:")
if [[ -z "$chosen" ]]; then
  exit 0
fi

cmd=$(printf "%s\n" "${options[@]}" | grep "^$chosen::" | cut -d ":" -f 3)
eval "$cmd"; hyprctl dispatch closewindow "title:wofi" 2>/dev/null; exit
