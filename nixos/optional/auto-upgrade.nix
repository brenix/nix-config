{ config, lib, ... }:
with lib; let
  cfg = config.modules.nixos.auto-upgrade;
in
{
  options.modules.nixos.auto-upgrade = {
    enable = mkEnableOption "Enable automatic upgrades";
  };

  config = mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      allowReboot = true;
      randomizedDelaySec = "120";
      rebootWindow = {
        lower = "03:00";
        upper = "06:00";
      };
      dates = "daily";
      flake = "gitlab:brenix/nix-config";
      flags = [
        "--refresh"
        # "--recreate-lock-file"
        # "--commit-lock-file"
        "--impure"
      ];
    };
  };
}
