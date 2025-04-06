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

  cfg = config.${namespace}.programs.graphical.wms.hyprland;
in {
  imports = with inputs;
    [
      hyprland-nix.homeManagerModules.default
    ]
    ++ lib.snowfall.fs.get-non-default-nix-files ./.;

  options.${namespace}.programs.graphical.wms.hyprland = {
    enable = mkBoolOpt false "enable hyprland window manager";
    swapCapsEsc = mkBoolOpt false "swap capslock with escape";
  };

  config = mkIf cfg.enable {
    nix.settings = {
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    xdg.configFile."hypr".recursive = true;

    home.packages = with pkgs; [
      hyprland-qtutils
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
      bars.yambar.enable = false;
      bars.waybar.enable = true;
      launchers.fuzzel.enable = true;
      notifications.fnott.enable = true;
    };
  };
}
