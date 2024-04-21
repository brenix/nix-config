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

    system = {
      fonts.enable = true;
    };

    desktops.addons.xdg.enable = true;

    programs = {
      discord.enable = true;
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
