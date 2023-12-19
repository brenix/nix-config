{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/optional/ananicy.nix
    ../common/optional/fonts.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/vmware-guest.nix
    ../common/optional/xserver.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.network.enable = true;
  networking.hostName = "tank";

  programs = {
    dconf.enable = true;
  };

  services.xserver = {
    dpi = 220;
  };

  environment.variables.WINIT_X11_SCALE_FACTOR = "1.5";
  environment.variables.GDK_SCALE = "2";
  environment.variables.GDK_DPI_SCALE = "0.4";

  system.stateVersion = "22.11";
}
