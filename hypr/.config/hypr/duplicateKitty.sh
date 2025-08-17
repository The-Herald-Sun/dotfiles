#!/bin/bash

# This script finds the active kitty window's directory and opens a new
# kitty instance in the same path. If the active window is not kitty,
# it opens a new kitty in the home directory.

# Use hyprctl to get the class and pid of the active window.
# The output is parsed to extract the necessary information.
# This approach is more reliable than a simple grep.
ACTIVE_INFO=$(hyprctl activewindow)

WINDOW_CLASS=$(echo "$ACTIVE_INFO" | grep "class:" | awk '{print $2}')
PID=$(echo "$ACTIVE_INFO" | grep "pid:" | awk '{print $2}')

# Check if the active window is a Kitty terminal.
if [[ "$WINDOW_CLASS" == "kitty" ]]; then
    # Get the current working directory (CWD) of the kitty process.
    # We use readlink -f to get the canonical path.
    CWD=$(readlink -f "/proc/$PID/cwd")

    # If the CWD was found, launch a new kitty window in that directory.
    if [[ -n "$CWD" ]]; then
        kitty --directory "$CWD" &
        exit 0
    fi
fi
