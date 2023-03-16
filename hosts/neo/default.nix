{ pkgs, inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./libvirt.nix
    ../common/global
    ../common/optional/autologin-console.nix
    ../common/optional/fonts.nix
    ../common/optional/freetype2-lcdfilter.nix
    /* ../common/optional/node-exporter.nix */
    ../common/optional/openconnect.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/xserver.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.postBootCommands = ''
    echo 1 >/sys/devices/pci0000:00/0000:00:03.2/0000:0e:00.0/reset
  '';

  programs = {
    /* adb.enable = true; */
    dconf.enable = true;
  };

  networking.hostName = "neo";
  networking.extraHosts = "192.168.1.10 api.kubernetes";

  services.resolved.domains = [ "localdomain" ];

  # services.ratbagd.enable = true;

  # services.irqbalance.enable = true;

  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/share" = {
    device = "//192.168.1.10/downloads";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts}" ];
  };

  services.xserver = {
    dpi = 108;
    displayManager = {
      sessionCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --mode 2560x1440
        ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --mode 2560x1440
        ${pkgs.xorg.xset}/bin/xset s off -dpms
      '';
    };
  };

  /* xdg.portal = { */
  /*   enable = true; */
  /*   wlr.enable = true; */
  /* }; */

  system.stateVersion = "22.05";
}
