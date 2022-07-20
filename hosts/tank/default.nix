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
    ../common/optional/vmware-guest.nix
    ../common/optional/xserver.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs = {
    dconf.enable = true;
  };

  services.xserver = {
    dpi = 220;
    displayManager = {
      sessionCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr -s '2880x1800'
      '';
    };
  };

  hardware.video.hidpi.enable = true;

  #environment.variables.WINIT_X11_SCALE_FACTOR = "1.5";
  #environment.variables.GDK_SCALE = "2";
  #environment.variables.GDK_DPI_SCALE = "0.5";

  system.stateVersion = "22.05";
}
