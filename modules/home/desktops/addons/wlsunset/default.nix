{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.desktops.addons.wlsunset;
in {
  options.desktops.addons.wlsunset = {
    enable = mkEnableOption "Enable wlsunset night light";
  };

  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;
      latitude = "38.752125";
      longitude = "-121.288010";
    };
  };
}
