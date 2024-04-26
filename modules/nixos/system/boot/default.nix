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
    plymouth = mkBoolOpt false "Whether or not to enable plymouth boot splash.";
    secureBoot = mkBoolOpt false "Whether or not to enable secure boot.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        efibootmgr
        efitools
        efivar
        fwupd
      ]
      ++ lib.optionals cfg.secureBoot [sbctl];

    boot = {
      kernelParams =
        [
          "mitigations=off"
          "usbcore.autosuspend=-1"
        ]
        ++ lib.optionals cfg.plymouth ["quiet" "splash" "loglevel=3" "udev.log_level=0"];

      lanzaboote = mkIf cfg.secureBoot {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };

      loader = {
        efi = {
          canTouchEfiVariables = true;
        };

        systemd-boot = {
          enable = !cfg.secureBoot;
          configurationLimit = 20;
          editor = false;
        };
      };

      plymouth = {
        enable = cfg.plymouth;
        theme = "catppuccin-mocha";
        themePackages = [(pkgs.catppuccin-plymouth.override {variant = "mocha";})];
      };

      tmp = {
        useTmpfs = true;
        tmpfsSize = "75%";
      };
    };

    services.fwupd.enable = true;

    # Enable cgroups v2
    systemd.enableUnifiedCgroupHierarchy = true;
  };
}
