#!/bin/bash

MUSIC=~/music
SCRIPT='[ -e "cache" ] && rm "cache"; rm -rf ~/.config/cmus/playlists/*; ~/projects/personal/cmup-pas/cmup ~/music ~/.config/cmus/playlists/'

find "$MUSIC" |
  entr -d -r bash -c "$SCRIPT"
