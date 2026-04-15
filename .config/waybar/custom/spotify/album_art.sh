#!/bin/bash
playback_info=$(spotify_player get key playback)
image_url=$(echo $playback_info | jq -r '.item.album.images[2].url')
if [[ -z $image_url ]] 
then
   # spotify is dead, we should die too.
   exit
fi
curl -s  "${image_url}" --output "/tmp/cover.jpeg"
echo "/tmp/cover.jpeg"

