{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt mkPackageOpt;

  cfg = config.${namespace}.programs.graphical.launchers.rofi;
in {
  options.${namespace}.programs.graphical.launchers.rofi = {
    enable = mkBoolOpt false "Enable rofi app manager";
    package = mkPackageOpt pkgs.rofi-wayland "Package to use for rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = cfg.package;
      terminal = "${pkgs.foot}/bin/foot";
      # catppuccin.enable = true;
      extraConfig = {
        modi = "run,drun,window";
        show-icons = true;
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 﩯  Window";
        display-Network = " 󰤨  Network";
        sidebar-mode = true;
      };
    };
  };
}
