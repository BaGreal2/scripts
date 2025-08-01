#!/usr/bin/env bash

tmux new-window -n "open-doc" "bash -c '
  DOCS_DIR=\"$HOME/Documents/Docs\"
  REL_PATH=\$(find \"\$DOCS_DIR\" -type f -name \"*.pdf\" | sed \"s|^\$DOCS_DIR/||\" | fzf --no-multi);
  if [ -n \"\$REL_PATH\" ]; then
    nohup zathura \"\$DOCS_DIR/\$REL_PATH\" >/dev/null 2>&1 &
  fi
  tmux kill-pane
'"
