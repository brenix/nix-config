{
  lib,
  config,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.profiles.desktop;
in {
  options.profiles.desktop = {
    enable = mkEnableOption "Enable desktop configuration";
  };

  config = mkIf cfg.enable {
    profiles = {
      common.enable = true;
      desktop.addons = {
        nautilus.enable = true;
      };
    };

    hardware = {
      audio.enable = true;
    };

    services = {
      matrix.avahi.enable = true;
      virtualisation.podman.enable = true;
    };

    system = {
      fonts.enable = true;
    };

    user = {
      name = "brenix";
      initialPassword = "1";
    };
  };
}
