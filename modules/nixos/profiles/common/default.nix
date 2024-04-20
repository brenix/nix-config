{ lib
, config
, ...
}:
with lib; let
  cfg = config.profiles.common;
in
{
  options.profiles.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    nix.enable = true;
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      # networking.enable = true;
    };

    services = {
      openssh.enable = true;
      ntp.enable = true;
    };

    security = {
      sops.enable = true;
    };

    system = {
      boot.enable = true;
      fonts.enable = true;
      locale.enable = true;
    };
  };
}
