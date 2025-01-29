#!/bin/sh

# Lock screen and pause all media
for player in $(playerctl --list-all); do
        playerctl --player="$player" pause;
done
pidof hyprlock || killall hyprlock && hyprlock
