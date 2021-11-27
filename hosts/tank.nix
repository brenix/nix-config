{ config, pkgs, ... }:

{
  imports = [
    ../configuration.nix
    ../hardware/vm-fusion.nix
    ../modules/settings.nix
  ];

  settings = {
    vm = true;
  };

  networking.hostName = "tank";
}
