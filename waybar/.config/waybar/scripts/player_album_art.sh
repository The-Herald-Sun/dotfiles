#!/usr/bin/env bash

PLAYER="chromium"

get_player_data() {
  ARTPATH=$(playerctl --player="${PLAYER}" metadata --format "{{mpris:artUrl}}" 2>/dev/null)
  echo "${ARTPATH:6}"
}

get_player_data
