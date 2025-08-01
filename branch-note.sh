#!/usr/bin/env bash

DIR="$HOME/notes/signus/"

mkdir -p "$DIR"

PANE_PATH="$(tmux display -p -F "#{pane_current_path}")"
if ! git -C "$PANE_PATH" rev-parse --git-dir >/dev/null 2>&1; then
  echo "Not a git repo: $PANE_PATH"
  exit 1
fi

BRANCH="$(git -C "$PANE_PATH" rev-parse --abbrev-ref HEAD 2>/dev/null)"
if [ -z "$BRANCH" ] || [ "$BRANCH" = "HEAD" ]; then
  BRANCH="$(git -C "$PANE_PATH" rev-parse --short HEAD 2>/dev/null)"
fi

SAFE="$(printf "%s" "$BRANCH" | tr '/ ' '--')"
FILE="$DIR/$SAFE.md"

if [ ! -e "$FILE" ]; then
  : > "$FILE"
fi

tmux new-window -n "note:$SAFE" "nvim \"$FILE\"; tmux kill-window"
