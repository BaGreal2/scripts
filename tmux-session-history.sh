#!/usr/bin/env bash

STATE="${XDG_CACHE_HOME:-$HOME/.cache}/tmux-session-history"
CUR="${STATE}.idx"
mkdir -p "$(dirname "$STATE")"; touch "$STATE" "$CUR"

clean_history() {
  sed -i '/^$/d' "$STATE"
  tail -n 100 "$STATE" > "${STATE}.tmp" && mv "${STATE}.tmp" "$STATE"
}

case $1 in
  add)
    sess="$2"
    grep -vxF "$sess" "$STATE" > "${STATE}.tmp" || true
    mv "${STATE}.tmp" "$STATE"
    echo "$sess" >> "$STATE"
    clean_history
    echo "$(wc -l < "$STATE")" > "$CUR"
    ;;

  back|forward)
    clean_history
    [ -s "$STATE" ] || exit 0
    total=$(wc -l < "$STATE")
    idx=$(<"$CUR"); [ -z "$idx" ] && idx=$total
    [[ $1 == back ]] && ((idx--)) || ((idx++))
    ((idx < 1 || idx > total)) && exit 0
    echo "$idx" > "$CUR"

    target=$(sed -n "${idx}p" "$STATE")
    [ -z "$target" ] && exit 0

    tmux set-environment -g _tsh_skip_add 1
    exec tmux switch-client -t "$target"
    ;;
esac
