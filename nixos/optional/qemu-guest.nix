{ config, lib, ... }:
with lib; let
  cfg = config.modules.nixos.qemu-guest;
in
{
  options.modules.nixos.qemu-guest = {
    enable = mkEnableOption "Enable qemu-guest";
  };

  config = mkIf cfg.enable {
    services = {
      qemuGuest.enable = true;
      spice-vdagentd.enable = true;
    };

    environment.systemPackages = [ pkgs.xorg.xf86videoqxl ];
  };
}
