#!/bin/bash

WALLPAPER_DIR="$HOME/Documents/Photos/Wallpapers"

# Collect image paths
FILES=()
while IFS= read -r -d $'\0' file; do
  FILES+=("$file")
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0)

if [ ${#FILES[@]} -eq 0 ]; then
  echo "No images found in $WALLPAPER_DIR"
  exit 1
fi

# Pick one randomly
RANDOM_INDEX=$(( RANDOM % ${#FILES[@]} ))
SELECTED="${FILES[$RANDOM_INDEX]}"

# Get current space
CURRENT_SPACE=$(yabai -m query --spaces --space | jq '.index')

# Get list of spaces
SPACES=$(yabai -m query --spaces | jq '.[].index')

for SPACE in $SPACES; do
  # Switch to space
  yabai -m space --focus "$SPACE"
  sleep 0.01

  # Set wallpaper on the current Space (using AppleScript)
  osascript -e "tell application \"System Events\" to set picture of desktop 1 to POSIX file \"$SELECTED\""
done

# Return to original space
yabai -m space --focus "$CURRENT_SPACE"

echo "Wallpaper set to: $SELECTED on all spaces."
