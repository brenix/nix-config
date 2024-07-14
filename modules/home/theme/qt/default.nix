{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.theme.qt;
in {
  options.${namespace}.theme.qt = {
    enable = mkBoolOpt false "enable qt theme management";
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
