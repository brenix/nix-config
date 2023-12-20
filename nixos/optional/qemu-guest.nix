{ pkgs, ... }:
{
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };

  environment.systemPackages = [ pkgs.xorg.xf86videoqxl ];
}
