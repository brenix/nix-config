if [[ $commands[convert] ]]; then
  screenshot() {
    local output=${1:-$HOME/screenshot.png}
    local screen1=/tmp/screen1.png
    local screen2=/tmp/screen2.png
    import -window root -crop 2560x1440+0+0 ${screen1}
    import -window root -crop 2560x1440+2560+0 ${screen2}
    convert -append ${screen1} ${screen2} ${output}
    rm ${screen1} ${screen2}
  }
fi
