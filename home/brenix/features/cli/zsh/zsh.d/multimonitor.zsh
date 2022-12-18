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
    xrandr --output HDMI-A-0 --mode 2560x1440 --rate 144 --left-of DisplayPort-0
    bspc desktop 1 -m HDMI-A-0
    bspc desktop 2 -m HDMI-A-0
    bspc desktop Desktop -r
  fi
}
