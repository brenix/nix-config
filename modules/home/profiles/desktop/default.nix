{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.profiles.desktop;
in {
  options.profiles.desktop = {
    enable = mkEnableOption "Enable desktop suite";
  };

  config = mkIf cfg.enable {
    profiles = {
      common.enable = true;
    };

    browsers.firefox.enable = true;

    home.packages = with pkgs; [
      mpv
      mupdf
      nsxiv
      pavucontrol
      playerctl
      xdg-utils
    ];

    desktops.addons = {
      gtk.enable = true;
      qt.enable = true;
      xdg.enable = true;
    };

    cli = {
      terminals.alacritty.enable = true;
    };

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
      LIBSEAT_BACKEND = "logind";
    };
  };
}
