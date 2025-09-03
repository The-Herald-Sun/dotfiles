#!/bin/bash

toggle_waybar() {
  if pgrep -x "waybar" >/dev/null; then
    pkill waybar
  else
    waybar &
  fi
}

toggle_waybar
