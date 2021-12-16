{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules =
    [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  # Enable qemu guest service
  services.qemuGuest.enable = true;

  # Enable spice guest daemon
  services.spice-vdagentd.enable = true;

  # Enable DHCP
  systemd.network.networks.enp1s0 = {
    matchConfig = { Name = "enp1s0"; };
    DHCP = "yes";
  };

  # Install qxl video driver
  environment.systemPackages = [ pkgs.xorg.xf86videoqxl ];
}
