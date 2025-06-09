#!/bin/bash

tmux new-window -n yt-search "fish -c 'yt-search; sleep 0.5; tmux kill-window'"
