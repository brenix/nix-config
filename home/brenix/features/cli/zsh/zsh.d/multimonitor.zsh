# Display single
ds() {
  if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    hyprctl keyword monitor HDMI-A-1,disable
  else
    xrandr --output HDMI-1 --off
  fi
}

# Display extend
de() {
  if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    hyprctl reload
  else
    xrandr --output HDMI-1 --mode 2560x1440 --right-of DP-1
    bspc desktop 3 -m HDMI-1
    bspc desktop 4 -m HDMI-1
    bspc desktop Desktop -r
  fi
}
