{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.addons.gammastep;
in {
  options.${namespace}.programs.graphical.addons.gammastep = {
    enable = mkBoolOpt false "Enable gammastep night light";
  };

  config = mkIf cfg.enable {
    services.gammastep = {
      enable = true;
      provider = "geoclue2";
      temperature = {
        day = 6000;
        night = 4600;
      };
      settings = {
        general.adjustment-method = "wayland";
      };
    };
  };
}
