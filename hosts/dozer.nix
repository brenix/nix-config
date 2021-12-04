{ config, ... }: {

  imports = [
    ../hardware/vm-qemu.nix
  ];

  # Hostname
  networking.hostName = "dozer";

  # DPI settings
  services.xserver.dpi = 109;

}
