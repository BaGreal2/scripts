#!/usr/bin/env bash

tmux new-window -n "open-image" "bash -c '
  IMAGES_DIR=\"$HOME/images\"
  REL_PATH=\$(find \"\$IMAGES_DIR\" -type f \( -iname \"*.png\" -o -iname \"*.jpg\" -o -iname \"*.jpeg\" -o -iname \"*.avif\" \) | sed \"s|^\$IMAGES_DIR/||\" | fzf --no-multi);
  if [ -n \"\$REL_PATH\" ]; then
    nohup open \"\$IMAGES_DIR/\$REL_PATH\" >/dev/null 2>&1 &
  fi
  tmux kill-pane
'"
