{ config, pkgs, ... }:

{
  imports = [
    ../configuration.nix
    ../hardware/vm-qemu.nix
    ../modules/settings.nix
  ];

  settings = {
    vm = true;
    primaryDisplay = "Virtual-1";
  };

  networking.hostName = "dozer";
}
