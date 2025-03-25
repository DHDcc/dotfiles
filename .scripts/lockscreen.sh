#!/bin/sh

pauseAllPlayers() {
  playerctl --all-players pause
}

pauseAllPlayers

if [ $(hyprctl locked) = "false" ] && pidof hyprlock >/dev/null; then
   killall hyprlock >/dev/null
fi

hyprlock
