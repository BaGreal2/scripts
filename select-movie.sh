#!/usr/bin/env bash

MOVIE_DIR="$HOME/videos/movies"

tmux new-window -n "watch-movie" "bash -c '
  DIR_NAME=\$(find \"$MOVIE_DIR\" -mindepth 1 -maxdepth 1 -type d | sed \"s|^$MOVIE_DIR/||\" | sort | fzf --no-multi --no-sort);
  if [ -n \"\$DIR_NAME\" ]; then
    DIR_PATH=\"$MOVIE_DIR/\$DIR_NAME\"
    FILE_NAME=\$(find \"\$DIR_PATH\" -mindepth 1 -maxdepth 1 -type f \\( -iname \"*.mp4\" -o -iname \"*.mkv\" -o -iname \"*.mov\" \\) | sed \"s|^\$DIR_PATH/||\" | sort | fzf --no-multi --no-sort);
    if [ -n \"\$FILE_NAME\" ]; then
      mpv \"\$DIR_PATH/\$FILE_NAME\" --fs
    fi
  fi
'"
