#!/bin/bash

MUSIC=~/Documents/Music
SCRIPT='[ -e "cache" ] && rm "cache"; rm -rf ~/.config/cmus/playlists/*; ~/Developer/personal/cmup-pas/cmup ~/Documents/Music ~/.config/cmus/playlists/'

find "$MUSIC" |
  entr -d -r bash -c "$SCRIPT"
