{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.desktops.addons.hyprpaper;
in {
  options.desktops.addons.hyprpaper = with types; {
    enable = mkBoolOpt false "Whether to enable the hyprpaper config";
  };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${pkgs.matrix.wallpapers.nix-catppuccin}"
        ];
        wallpaper = [", ${pkgs.matrix.wallpapers.nix-catppuccin}"];
      };
    };
  };
}
