{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.roles.common;
in {
  options.${namespace}.roles.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    networking.firewall.enable = false;

    programs.fish.enable = true;

    environment.systemPackages = with pkgs; [
      uutils-coreutils-noprefix
      usbutils
    ];

    matrix = {
      programs = {
        terminal = {
          tools = {
            nh.enable = true;
          };
        };
      };

      services = {
        ananicy.enable = true;
        ssh.enable = true;
        systemd = {
          timesyncd = {
            enable = true;
            servers = ["192.168.1.1"];
          };
          resolved.enable = true;
          resolved.domains = ["lan"];
        };
      };

      security.sops.enable = true;

      system = {
        boot.enable = true;
        impermanence.enable = true;
        locale.enable = true;
        nix.enable = true;
        sysctl.enable = true;
      };
    };

    services = {
      # bpftune.enable = true;
      dbus.enable = true;
      dbus.implementation = "broker";
    };

    security = {
      sudo.wheelNeedsPassword = false;
    };
  };
}
