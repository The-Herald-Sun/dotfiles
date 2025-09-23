#!/usr/bin/env python3

import subprocess
import json
import sys


def get_spotify_data():
    """
    Uses playerctl to get the current song data from the Spotify client.
    Returns a JSON object formatted for Waybar.
    """
    player = "chromium"  # Extract player into a variable

    try:
        # Check if the playerctl command is available
        subprocess.run(["playerctl"], capture_output=True, check=True)
    except FileNotFoundError:
        return {
            "text": " playerctl missing",
            "tooltip": "playerctl is not installed. Please install it.",
            "class": "error",
        }
    except subprocess.CalledProcessError:
        # This is expected if no players are active, so we continue.
        pass

    try:
        # Get the status of the Spotify player
        status = subprocess.run(
            ["playerctl", f"--player={player}", "status"],
            capture_output=True,
            text=True,
            check=False,
        ).stdout.strip()

        if status == "Playing":
            # Get metadata for the playing song
            title = subprocess.run(
                [
                    "playerctl",
                    f"--player={player}",
                    "metadata",
                    "--format",
                    "{{title}}",
                ],
                capture_output=True,
                text=True,
                check=False,
            ).stdout.strip()

            artist = subprocess.run(
                [
                    "playerctl",
                    f"--player={player}",
                    "metadata",
                    "--format",
                    "{{artist}}",
                ],
                capture_output=True,
                text=True,
                check=False,
            ).stdout.strip()

            icon = ""
            text = f"{title} {icon} {artist}"
            tooltip = f"<b>{title}</b>\nby {artist}"
            waybar_class = "playing"

        elif status == "Paused":
            # Get metadata for the paused song
            title = subprocess.run(
                [
                    "playerctl",
                    f"--player={player}",
                    "metadata",
                    "--format",
                    "{{title}}",
                ],
                capture_output=True,
                text=True,
                check=False,
            ).stdout.strip()

            artist = subprocess.run(
                [
                    "playerctl",
                    f"--player={player}",
                    "metadata",
                    "--format",
                    "{{artist}}",
                ],
                capture_output=True,
                text=True,
                check=False,
            ).stdout.strip()

            icon = ""
            text = f"{icon} {title}"
            tooltip = f"<b>{title}</b>\nby {artist}"
            waybar_class = "paused"

        else:
            # Player is either stopped or there's no active player
            icon = ""
            text = f"{icon} Not playing"
            tooltip = "Nothing is currently playing on Spotify."
            waybar_class = "paused"

        return {
            "text": text,
            "tooltip": tooltip,
            "class": waybar_class,
        }

    except subprocess.CalledProcessError as e:
        return {
            "text": "Error  ",
            "tooltip": f"playerctl error: {e.stderr.strip()}",
            "class": "error",
        }
    except Exception as e:
        return {
            "text": " Unknown error",
            "tooltip": f"An unexpected error occurred: {e}",
            "class": "error",
        }


if __name__ == "__main__":
    print(json.dumps(get_spotify_data()))
