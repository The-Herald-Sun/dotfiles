#!/usr/bin/env bash

PLAYER="chromium"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

get_spotify_data() {
  # Check for playerctl
  if ! command_exists playerctl; then
    jq -n -c --arg text " playerctl missing" \
      --arg tooltip "playerctl is not installed. Please install it." \
      --arg class "error" \
      '{text: $text, tooltip: $tooltip, class: $class}'
    return 0
  fi

  # Check for jq
  if ! command_exists jq; then
    echo '{"text": " jq missing", "tooltip": "jq is required for JSON output.", "class": "error"}'
    return 0
  fi

  STATUS=$(playerctl --player="${PLAYER}" status 2>/dev/null)
  EXIT_CODE=$?

  if [[ $EXIT_CODE -ne 0 && -n $STATUS ]]; then
    jq -n -c --arg text "Error " \
      --arg tooltip "playerctl error: $STATUS" \
      --arg class "error" \
      '{text: $text, tooltip: $tooltip, class: $class}'
    return 0
  fi

  if [[ "${STATUS}" == "Playing" ]]; then
    TITLE=$(playerctl --player="${PLAYER}" metadata --format "{{title}}" 2>/dev/null)
    ARTIST=$(playerctl --player="${PLAYER}" metadata --format "{{artist}}" 2>/dev/null)
    ICON=""
    TEXT="${TITLE} ${ICON} ${ARTIST}"
    TOOLTIP="<b>${TITLE}</b>\nby ${ARTIST}"
    CLASS="playing"

  elif [[ "${STATUS}" == "Paused" ]]; then
    TITLE=$(playerctl --player="${PLAYER}" metadata --format "{{title}}" 2>/dev/null)
    ARTIST=$(playerctl --player="${PLAYER}" metadata --format "{{artist}}" 2>/dev/null)
    ICON=""
    TEXT="${ICON} ${TITLE}"
    TOOLTIP="<b>${TITLE}</b>\nby ${ARTIST}"
    CLASS="paused"

  else
    ICON=""
    TEXT="${ICON} Not playing"
    TOOLTIP="Nothing is currently playing."
    CLASS="paused"
  fi

  # The crucial -c flag ensures compact JSON output
  jq -n -c --arg text "${TEXT}" \
    --arg tooltip "${TOOLTIP}" \
    --arg class "${CLASS}" \
    '{text: $text, tooltip: $tooltip, class: $class}'
}

get_spotify_data
