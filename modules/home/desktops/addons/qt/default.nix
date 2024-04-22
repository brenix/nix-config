{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.desktops.addons.qt;
in {
  options.desktops.addons.qt = {
    enable = mkEnableOption "enable qt theme management";
  };

  config = mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "Catppuccin-Mocha-Compact-Blue-Dark";
      style.package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "compact";
        tweaks = ["rimless"];
        variant = "mocha";
      };
    };
  };
}
