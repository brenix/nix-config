# Display single
ds() {
  if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    hyprctl keyword monitor HDMI-A-1,disable
  else
    xrandr --output HDMI-A-0 --off
  fi
}

# Display extend
de() {
  if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    hyprctl reload
  else
    xrandr --output HDMI-A-0 --mode 2560x1440 --right-of DisplayPort-0
    bspc desktop 3 -m HDMI-A-0
    bspc desktop 4 -m HDMI-A-0
    bspc desktop Desktop -r
  fi
}
