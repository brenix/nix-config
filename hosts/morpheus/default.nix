{ pkgs, inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix
    ../common/global
    ../common/optional/ananicy.nix
    ../common/optional/autologin-console.nix
    ../common/optional/auto-hibernate.nix
    ../common/optional/clipcat.nix
    ../common/optional/fonts.nix
    ../common/optional/openconnect.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/wireless.nix
    ../common/optional/xserver.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [
      "mem_sleep_default=deep"
      "nvme.noacpi=1"
      "btusb.enable_autosuspend=n"
      "i915.enable_psr=0"
      # "resume_offset=533760"
    ];

    blacklistedKernelModules = [ "hid-sensor-hub" ];
    resumeDevice = "/dev/disk/by-label/morpheus";
  };

  networking.hostName = "morpheus";

  services.fwupd.enable = true;

  services.resolved.domains = [ "lan" ];

  services.geoclue2.enable = true;

  # Fix suspend/wake - https://github.com/NixOS/nixos-hardware/tree/master/framework/13-inch/7040-amd#suspendwake-workaround
  hardware.framework.amd-7040.preventWakeOnAC = true;

  services.xserver.dpi = 208;

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  # };

  system.stateVersion = "23.11";
}
