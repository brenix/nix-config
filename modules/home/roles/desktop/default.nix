{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.roles.desktop;
in {
  options.roles.desktop = {
    enable = mkEnableOption "Enable desktop profile";
  };

  config = mkIf cfg.enable {
    roles = {
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
      terminals.foot.enable = true;
    };

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
      LIBSEAT_BACKEND = "logind";
    };
  };
}
