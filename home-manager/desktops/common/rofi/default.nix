{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.wms.launchers.rofi;
in
{
  options.modules.wms.launchers.rofi = {
    enable = mkEnableOption "enable rofi launcher";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      font = "${config.my.settings.fonts.regular} 10";
      theme = "Arc";
      plugins = with pkgs; [ rofi-calc rofi-emoji rofi-rbw ];
      extraConfig = {
        modi = "drun,run,emoji,calc,combi";
        dpi = config.my.settings.dpi;
      };
      terminal = config.my.settings.default.terminal;
    };

    home.file.".config/rofi/nord.rasi" = {
      source = ./nord.rasi;
    };

    home.file.".config/rofi/catppuccin-mocha.rasi" = {
      source = ./catppuccin-mocha.rasi;
    };

    home.file.".config/rofi/zenbox.rasi" = {
      source = ./zenbox.rasi;
    };
  };
}
