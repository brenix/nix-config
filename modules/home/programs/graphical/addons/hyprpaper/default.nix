{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.addons.hyprpaper;
in {
  options.${namespace}.programs.graphical.addons.hyprpaper = {
    enable = mkBoolOpt false "Whether to enable the hyprpaper config";
  };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${pkgs.${namespace}.wallpapers.nix-catppuccin}"
        ];
        wallpaper = [", ${pkgs.${namespace}.wallpapers.nix-catppuccin}"];
      };
    };
  };
}
