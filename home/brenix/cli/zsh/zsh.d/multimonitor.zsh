# Display single
ds() {
  xrandr --output HDMI-A-0 --off
  # hyprctl keyword monitor HDMI-A-1,disable
}

# Display extend
de() {
  # hyprctl reload
  xrandr --output HDMI-A-0 --mode 2560x1440 --rate 144 --right-of DisplayPort-0
  bspc desktop 3 -m HDMI-A-0
  bspc desktop 4 -m HDMI-A-0
  bspc desktop Desktop -r
}
