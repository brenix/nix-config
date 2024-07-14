{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.roles.desktop;
in {
  options.${namespace}.roles.desktop = {
    enable = mkEnableOption "Enable desktop configuration";
  };

  config = mkIf cfg.enable {
    matrix = {
      roles = {
        common.enable = true;
      };

      hardware = {
        audio.enable = true;
      };

      services = {
        avahi.enable = true;
      };

      system = {
        fonts.enable = true;
      };

      user = {
        name = "brenix";
        initialPassword = "1";
      };
    };

    services.avahi.enable = true;
  };
}
