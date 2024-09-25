{
  config,
  inputs,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.wms.labwc;
in {
  options.${namespace}.programs.graphical.wms.labwc = {
    enable = mkBoolOpt false "enable labwc window manager";
    swapCapsEsc = mkBoolOpt false "swap capslock with escape";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      labwc
      grimblast
      wl-clipboard
    ];

    ${namespace}.programs.graphical = {
      addons = {
        hyprpaper.enable = true;
        kanshi.enable = true;
        wlogout.enable = true;
        wlsunset.enable = false;
      };
      bars.yambar.enable = true;
      launchers.fuzzel.enable = true;
      notifications.fnott.enable = true;
    };
  };
}
