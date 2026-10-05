#!/usr/bin/env sh

COVER_CACHE="$HOME/.cache/sketchybar/spotify_art.png"

next ()
{
  osascript -e 'tell application "Spotify" to play next track'
}

back () 
{
  osascript -e 'tell application "Spotify" to play previous track'
}

play () 
{
  osascript -e 'tell application "Spotify" to playpause'
}

repeat () 
{
  REPEAT=$(osascript -e 'tell application "Spotify" to get repeating')
  if [ "$REPEAT" = "false" ]; then
    sketchybar -m --set spotify.repeat icon.highlight=on
    osascript -e 'tell application "Spotify" to set repeating to true'
  else 
    sketchybar -m --set spotify.repeat icon.highlight=off
    osascript -e 'tell application "Spotify" to set repeating to false'
  fi
}

shuffle () 
{
  SHUFFLE=$(osascript -e 'tell application "Spotify" to get shuffling')
  if [ "$SHUFFLE" = "false" ]; then
    sketchybar -m --set spotify.shuffle icon.highlight=on
    osascript -e 'tell application "Spotify" to set shuffling to true'
  else 
    sketchybar -m --set spotify.shuffle icon.highlight=off
    osascript -e 'tell application "Spotify" to set shuffling to false'
  fi
}

update_cover ()
{
  ART_URL="$(echo "$INFO" | jq -r '.["Artwork URL"] // empty')"
  if [ -z "$ART_URL" ]; then
    ART_URL="$(osascript -e 'tell application "Spotify" to get artwork url of current track' 2>/dev/null)"
  fi
  if [ -z "$ART_URL" ] || [ "$ART_URL" = "missing value" ]; then
    return 1
  fi
  mkdir -p "$(dirname "$COVER_CACHE")"
  TMP_RAW="$(dirname "$COVER_CACHE")/spotify_art_raw_$$"
  TMP_PNG="$(dirname "$COVER_CACHE")/spotify_art_$$.png"
  if curl -fsSL --max-time 5 "$ART_URL" -o "$TMP_RAW"; then
    if sips -Z 48 -s format png "$TMP_RAW" --out "$TMP_PNG" >/dev/null 2>&1; then
      mv "$TMP_PNG" "$COVER_CACHE"
      rm -f "$TMP_RAW"
      return 0
    fi
    rm -f "$TMP_PNG"
  fi
  rm -f "$TMP_RAW"
  return 1
}

update ()
{
  PLAYING=1
  if [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Playing" ]; then
    PLAYING=0
    TRACK="$(echo "$INFO" | jq -r .Name | cut -c1-20)"
    ARTIST="$(echo "$INFO" | jq -r .Artist | cut -c1-20)"
    ALBUM="$(echo "$INFO" | jq -r .Album | cut -c1-20)"
    SHUFFLE=$(osascript -e 'tell application "Spotify" to get shuffling')
    REPEAT=$(osascript -e 'tell application "Spotify" to get repeating')
  fi

  args=()
  if [ $PLAYING -eq 0 ]; then
    if [ "$ARTIST" == "" ]; then
      args+=(--set spotify.name label="$TRACK    $ALBUM" drawing=on)
    else
      args+=(--set spotify.name label="$TRACK    $ARTIST" drawing=on)
    fi
    args+=(--set spotify.play icon=󰐊 \
           --set spotify.shuffle icon.highlight=$SHUFFLE \
           --set spotify.repeat icon.highlight=$REPEAT)
    if update_cover; then
      args+=(--set spotify.cover background.image="$COVER_CACHE" drawing=on)
    fi
  else
    args+=(--set spotify.name drawing=off \
           --set spotify.name popup.drawing=off \
           --set spotify.play icon= \
           --set spotify.cover drawing=off)
  fi
  sketchybar -m "${args[@]}"
}

mouse_clicked () {
  case "$NAME" in
    "spotify.next") next
    ;;
    "spotify.back") back
    ;;
    "spotify.play") play
    ;;
    "spotify.shuffle") shuffle
    ;;
    "spotify.repeat") repeat
    ;;
    *) exit
    ;;
  esac
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "forced") exit
  ;;
  *) update
  ;;
esac
