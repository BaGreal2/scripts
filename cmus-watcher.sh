#!/usr/bin/env bash
LAST=""
while true; do
  NEW=$(/Users/xanin/tmp/cmus/usr/local/bin/cmus-remote -C status 2>/dev/null)
  [[ "$NEW" != "$LAST" ]] && /opt/homebrew/bin/sketchybar --trigger cmus_update 
  LAST="$NEW"
  sleep 1
done
