# Display single
ds() {
  hyprctl keyword monitor HDMI-A-1,disable
}

# Display extend
de() {
  hyprctl reload
  # bspc desktop 3 -m HDMI-A-0
  # bspc desktop 4 -m HDMI-A-0
  # bspc desktop Desktop -r
}
