{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/optional/fonts.nix
    ../common/optional/freetype2-lcdfilter.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/xserver.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs = {
    dconf.enable = true;
  };

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  environment.systemPackages = [ pkgs.xorg.xf86videoqxl ];

  system.stateVersion = "22.05";
}
