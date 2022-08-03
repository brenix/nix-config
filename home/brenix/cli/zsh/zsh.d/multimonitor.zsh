# Display single
ds() {
  wlr-randr --output HDMI-A-1 --off
}

# Display extend
de() {
  wlr-randr --output HDMI-A-1 --mode 2560x1440 --rate 144 --right-of DP-1
  # bspc desktop 3 -m HDMI-A-0
  # bspc desktop 4 -m HDMI-A-0
  # bspc desktop Desktop -r
}
