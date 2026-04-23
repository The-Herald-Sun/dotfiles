#!/bin/env bash

activeWorkspaceId="$(hyprctl activeworkspace -j | jq -r '.id')"

currentLayout=$(hyprctl activeworkspace -j | jq -r '.layout')

if [ "$currentLayout" == "dwindle" ]; then
  echo "Dwindle layout in workspace $activeWorkspaceId"
  hyprctl keyword "workspace = $activeWorkspaceId, layout:scrolling"
else
  echo "Not Dwindle in workspace $activeWorkspaceId"
  hyprctl keyword "workspace = $activeWorkspaceId, layout:dwindle"
fi
