{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.roles.desktop;
in {
  options.${namespace}.roles.desktop = {
    enable = mkBoolOpt false "Enable desktop profile";
  };

  config = mkIf cfg.enable {
    matrix = {
      roles = {
        common.enable = true;
      };

      programs = {
        graphical = {
          browsers.firefox.enable = true;
        };

        terminal = {
          emulators.alacritty.enable = false;
          emulators.foot.enable = true;
          emulators.ghostty.enable = false;
          tools.spotify-player.enable = false;
        };
      };

      theme = {
        gtk.enable = true;
        qt.enable = true;
      };

      system = {
        xdg.enable = pkgs.stdenv.isLinux;
      };
    };

    home.packages = with pkgs; [
      mpv
      mupdf
      nsxiv
      pavucontrol
      playerctl
      xdg-utils
    ];

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
      LIBSEAT_BACKEND = "logind";
    };
  };
}
