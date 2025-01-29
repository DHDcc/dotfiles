#!/usr/bin/sh

wallpapersDirectory="${HOME:-/home/$USER}/.config/swww/wallpapers"
wallpapersListFile="/tmp/wallpapers_file.txt"
numberOfWallpapersInFile=$(wc -l < "${wallpapersListFile}")
swwwTransitionFps="120"
swwwTransitionType="grow"
swwwTransitionPos="bottom-right"
swwwTransitionDurationInSeconds="2"
shuffleWallpapers(){ 
  find "${wallpapersDirectory}" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) -printf '%f\n' | shuf > "${wallpapersListFile}"
}

if [ ! -f "${wallpapersListFile}" ] || [ "${numberOfWallpapersInFile}" -eq "0" ]; then
     shuffleWallpapers
fi

randomWallpaperName="$(head -1 "${wallpapersListFile}")"
randomWallpaperPath="${wallpapersDirectory}/${randomWallpaperName}"

swww query || swww-daemon

if [ -f "${randomWallpaperPath}" ]; then
    echo "Setting wallpaper to ${randomWallpaperPath}"
    #notify-send -t 1710 -i $HOME/icons/wallpapers.icon.png --hint int:transient:1 "Changing wallpaper...."
    swww img "${randomWallpaperPath}" \
         --transition-fps "${swwwTransitionFps}" \
         --transition-type "${swwwTransitionType}" \
         --transition-pos "${swwwTransitionPos}" \
         --transition-duration "${swwwTransitionDurationInSeconds}"
    sed -i "/${randomWallpaperName}/d" "${wallpapersListFile}"
else
   echo "Error: Image file not found: ${randomWallpaperPath}" >&2
   exit 1
fi
