#!/bin/bash

# Get the current value of gaps_in from the "custom type" output.
# The `awk` command is configured to print the third field, which is the first number.
CURRENT_GAPS_IN=$(hyprctl getoption general:gaps_in | awk '{print $3}')

# waybar_on() {
#   if ! pgrep -x "waybar" >/dev/null; then
#     waybar &
#   fi
# }
waybar_on() {
  if pgrep -x waybar >/dev/null; then
    # Waybar is running, send SIGUSR1 to show it (in case it's hidden)
    killall -SIGUSR1 waybar
  else
    # Waybar is not running, start it
    waybar &
  fi
}

waybar_off() {
  if pgrep -x "waybar" >/dev/null; then
    # pkill waybar
    killall -SIGUSR1 waybar || waybar
  fi
}

# Check if the value is an integer and perform the toggle.
if [ "$CURRENT_GAPS_IN" -eq 0 ]; then
  waybar_on
  # State is no gaps, switch to gaps
  hyprctl keyword general:gaps_in 5
  hyprctl keyword general:gaps_out 10
  hyprctl keyword general:border_size 4
  hyprctl keyword decoration:rounding 10
else
  waybar_off
  # State is gaps, switch to no gaps
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
  hyprctl keyword general:border_size 2
  hyprctl keyword decoration:rounding 0
fi
