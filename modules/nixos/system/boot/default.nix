{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.matrix) mkBoolOpt;

  cfg = config.system.boot;
in {
  options.system.boot = {
    enable = mkBoolOpt false "Whether or not to enable booting.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      efibootmgr
      efitools
      efivar
      fwupd
    ];

    boot = {
      kernelParams = [
        "mitigations=off"
        "usbcore.autosuspend=-1"
      ];

      loader = {
        efi = {
          canTouchEfiVariables = true;
        };

        systemd-boot = {
          enable = true;
          configurationLimit = 20;
          editor = false;
        };
      };

      tmp = {
        useTmpfs = true;
        tmpfsSize = "75%";
      };
    };

    services.fwupd = {
      enable = true;
      daemonSettings.EspLocation = config.boot.loader.efi.efiSysMountPoint;
    };

    # Enable cgroups v2
    systemd.enableUnifiedCgroupHierarchy = true;
  };
}
