# Display single
ds() {
  xrandr --output HDMI-0 --off
}

# Display extend
de() {
  xrandr --output HDMI-0 --mode 2560x1440 --rate 144 --right-of DP-4
  bspc desktop 4 -m HDMI-0
  bspc desktop 5 -m HDMI-0
  bspc desktop 6 -m HDMI-0
  bspc desktop Desktop -r
}
