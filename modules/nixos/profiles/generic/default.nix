{ lib
, config
, ...
}:
with lib; let
  cfg = config.profiles.generic;
in
{
  options.profiles.generic = {
    enable = mkEnableOption "Enable generic configuration";
  };

  config = mkIf cfg.enable {
    nix.enable = true;

    services = {
      ananicy.enable = true;
      # bpftune.enable = true;
      dbus.enable = true;
      ntp.enable = true;
      openssh.enable = true;
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
