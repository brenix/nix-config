{ config, pkgs, ... }: {

  imports = [ ../../modules/settings.nix ];

  programs.rofi = {
    enable = true;
    font = "${config.settings.fonts.launcher.font} ${
        toString config.settings.fonts.launcher.size
      }";
    theme = "Arc";
    plugins = with pkgs; [ rofi-calc ];
    extraConfig = { dpi = config.settings.dpi; };
  };

}
