#!/bin/bash

# Define your wallpaper directory
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"

# Get the target desktop number from the script argument
TARGET_DESKTOP="$1"

WALLPAPER="${WALLPAPER_DIR}w_${TARGET_DESKTOP}.jpg"

# Check if the wallpaper file exists before trying to set it
if [ -f "$WALLPAPER" ]; then
  swww img "$WALLPAPER" \
    --transition-type fade --transition-duration 0.1 --transition-fps 60
else
  echo "Error: Wallpaper not found for desktop $TARGET_DESKTOP: $WALLPAPER"
  # Optional: You could set a default wallpaper here if the specific one is missing
  # swww img "${WALLPAPER_DIR}default.jpg"
fi
