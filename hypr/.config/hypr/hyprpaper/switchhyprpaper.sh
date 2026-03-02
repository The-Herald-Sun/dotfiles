#!/bin/bash
hyprctl hyprpaper wallpaper "eDP-1, $1" &&
  sed -i "s|  path = .*|  path = $1|" ~/.config/hypr/hyprpaper/wallpaper.conf
