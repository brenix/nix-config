{ pkgs, inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./libvirt.nix
    ../common/global
    ../common/optional/fonts.nix
    ../common/optional/freetype2-lcdfilter.nix
    ../common/optional/node-exporter.nix
    ../common/optional/openconnect.nix
    ../common/optional/passwordless-sudo.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/xserver.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  services.udev.packages = [ pkgs.android-udev-rules ];

  services.ratbagd.enable = true;

  services.xserver.dpi = 109;

  hardware = {
    opengl.enable = true;
  };

  system.stateVersion = "22.05";
}
