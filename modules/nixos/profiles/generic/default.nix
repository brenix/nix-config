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

    chaotic = {
      nyx.overlay.enable = true;
    };

    services = {
      ananicy.enable = true;
      # bpftune.enable = true;
      dbus.enable = true;
      openssh.enable = true;
      systemd = {
        timesyncd.enable = true;
        resolved.enable = true;
      };
    };

    security = {
      sops.enable = true;
    };

    system = {
      boot.enable = true;
      impermanence.enable = true;
      locale.enable = true;
      sysctl.enable = true;
    };
  };
}
