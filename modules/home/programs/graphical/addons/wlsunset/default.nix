{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.addons.wlsunset;
in {
  options.${namespace}.programs.graphical.addons.wlsunset = {
    enable = mkBoolOpt false "Enable wlsunset night light";
  };

  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;
      latitude = "38.752125";
      longitude = "-121.288010";
    };
  };
}
