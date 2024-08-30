{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.theme.gtk;
in {
  options.${namespace}.theme.gtk = {
    enable = mkBoolOpt false "enable gtk theme management";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        # package = pkgs.orchis-theme;
        # name = "Orchis-Light-Compact";

        package = pkgs.nordic;
        name = "Nordic";
      };
    };
  };
}
