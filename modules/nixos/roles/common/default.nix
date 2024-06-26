{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.roles.common;
in {
  options.roles.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    networking.firewall.enable = false;

    programs.fish.enable = true;

    cli.programs = {
      nh.enable = true;
    };

    services = {
      ananicy.enable = true;
      # bpftune.enable = true;
      dbus.enable = true;
      ssh.enable = true;
      systemd = {
        timesyncd.enable = true;
        resolved.enable = true;
        resolved.domains = ["lan"];
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
