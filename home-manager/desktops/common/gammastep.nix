{ config, lib, ... }:
{
  services.gammastep = lib.mkIf (!config.my.settings.headless) {
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
}
