#!/bin/bash

CORE_AGENTS=(
  "/Library/LaunchAgents/com.sentinelone.agent.plist"
)

HELPER_DAEMONS=(
  "/Library/LaunchDaemons/com.sentinelone.sentineld-guard.plist"
  "/Library/LaunchDaemons/com.sentinelone.sentineld-helper.plist"
  "/Library/LaunchDaemons/com.sentinelone.sentineld-shell.plist"
  "/Library/LaunchDaemons/com.sentinelone.sentinel-extensions.plist"
  "/Library/LaunchDaemons/com.sentinelone.sentineld.plist"
)

HELPER_AGENTS=(
  "/Library/LaunchAgents/com.sentinelone.agent-helper.plist"
)

if [ "$1" == "minimal" ]; then
  echo "Setting SentinelOne to minimal mode..."

  # for plist in "${CORE_DAEMONS[@]}"; do
  #   sudo launchctl bootstrap system "$plist" 2>/dev/null
  # done
  for plist in "${CORE_AGENTS[@]}"; do
    launchctl bootstrap gui/$(id -u) "$plist" 2>/dev/null
  done

  for plist in "${HELPER_DAEMONS[@]}"; do
    sudo launchctl bootout system "$plist" 2>/dev/null
  done
  for plist in "${HELPER_AGENTS[@]}"; do
    launchctl bootout gui/$(id -u) "$plist" 2>/dev/null
  done

  echo "SentinelOne set to minimal mode."

elif [ "$1" == "off" ]; then
  echo "Turning OFF SentinelOne completely..."
  for plist in "${CORE_DAEMONS[@]}" "${HELPER_DAEMONS[@]}"; do
    sudo launchctl bootout system "$plist" 2>/dev/null
  done
  for plist in "${CORE_AGENTS[@]}" "${HELPER_AGENTS[@]}"; do
    launchctl bootout gui/$(id -u) "$plist" 2>/dev/null
  done
  echo "SentinelOne fully disabled."

elif [ "$1" == "on" ]; then
  echo "Turning ON SentinelOne completely..."
  for plist in "${CORE_DAEMONS[@]}" "${HELPER_DAEMONS[@]}"; do
    sudo launchctl bootstrap system "$plist" 2>/dev/null
  done
  for plist in "${CORE_AGENTS[@]}" "${HELPER_AGENTS[@]}"; do
    launchctl bootstrap gui/$(id -u) "$plist" 2>/dev/null
  done
  echo "SentinelOne fully re-enabled."

else
  echo "Usage: $0 [on|off|minimal]"
  exit 1
fi
