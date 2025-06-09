#!/usr/bin/env bash

NOTE_DIR="$HOME/Documents/Notes"

tmux new-window -n "peek-note" "bash -c '
  FILE=\$(find \"$NOTE_DIR\" -type f -name \"*.md\" | fzf);
  if [ -n \"\$FILE\" ]; then
    nvim \"\$FILE\"
  fi
'"
