#!/usr/bin/env bash

tmux new-window -n "peek-note" "bash -c '
  NOTE_DIR=\"$HOME/notes\"
  REL_PATH=\$(find \"\$NOTE_DIR\" -type f -name \"*.md\" | sed \"s|^\$NOTE_DIR/||\" | fzf --no-multi --preview=\"bat --style=numbers --color=always \$NOTE_DIR/{}\" --preview-window=right:60%);
  if [ -n \"\$REL_PATH\" ]; then
    nvim \"\$NOTE_DIR/\$REL_PATH\"
  fi
'"
