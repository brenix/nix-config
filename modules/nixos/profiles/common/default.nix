{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.profiles.common;
in {
  options.profiles.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    networking.firewall.enable = false;

    services = {
      ananicy.enable = true;
      # bpftune.enable = true;
      dbus.enable = true;
      ssh.enable = true;
      systemd = {
        timesyncd.enable = true;
        resolved.enable = true;
      };
    };

    security = {
      sops.enable = true;
      sudo.wheelNeedsPassword = false;
    };

    system = {
      boot.enable = true;
      impermanence.enable = true;
      locale.enable = true;
      nix.enable = true;
      sysctl.enable = true;
    };
  };
}
