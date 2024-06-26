{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.desktops.hyprland;
in {
  imports = with inputs;
    [
      hyprland-nix.homeManagerModules.default
    ]
    ++ lib.snowfall.fs.get-non-default-nix-files ./.;

  options.desktops.hyprland = {
    enable = mkEnableOption "enable hyprland window manager";
    swapCapsEsc = mkBoolOpt false "swap capslock with escape";
  };

  # FIX: this hack to use nix catppuccin module: https://github.com/catppuccin/nix/issues/102
  options.wayland.windowManager.hyprland = {
    settings = mkEnableOption "enable hyprland window manager";
  };

  config = mkIf cfg.enable {
    nix.settings = {
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    xdg.configFile."hypr".recursive = true;

    home.packages = with pkgs; [
      grimblast
      wl-clipboard
    ];

    desktops.addons = {
      hyprpaper.enable = true;
      kanshi.enable = true;
      mako.enable = true;
      rofi.enable = true;
      waybar.enable = true;
      wlogout.enable = true;
      wlsunset.enable = true;
    };
  };
}
