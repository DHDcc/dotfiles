#!/bin/sh

lockscreenScriptPath="$HOME/.scripts/lockscreen.sh"

sh "${lockscreenScriptPath}" & systemctl suspend
