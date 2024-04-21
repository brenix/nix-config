{
  lib,
  config,
  ...
}:
with lib;
with lib.nixicle; let
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
      logitechMouse.enable = true;
    };

    virtualisation = {
      podman.enable = true;
    };

    services = {
      nixicle.avahi.enable = true;
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
