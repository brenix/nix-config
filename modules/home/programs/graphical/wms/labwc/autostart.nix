{pkgs, ...}: {
  programs.labwc.autostart = [
    # FIXME: Hacks to get around graphical-session.target issues
    "${pkgs.yambar}/bin/yambar"
    "systemctl --user start fnott.service kanshi.service hyprpaper.service"
  ];
}
