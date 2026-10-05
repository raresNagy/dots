#!/bin/sh

# Called per workspace item (arg $1 = workspace id) on:
#   - aerospace_workspace_change (from AeroSpace via exec-on-workspace-change)
#   - front_app_switched (catches windows opening/closing)
# Shows the focused workspace (always) and non-empty workspaces, highlighting
# the focused one.

SID="$1"
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
COUNT="$(aerospace list-windows --workspace "$SID" --count 2>/dev/null)"

if [ "$SID" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" drawing=on background.drawing=on \
             background.color=0xffffffff icon.color=0xff000000
elif [ "$COUNT" -gt 0 ]; then
  sketchybar --set "$NAME" drawing=on background.drawing=off \
             icon.color=0xffffffff
else
  sketchybar --set "$NAME" drawing=off
fi
