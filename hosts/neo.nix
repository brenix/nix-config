{ config, pkgs, ... }:

{
  imports = [
    ../configuration.nix
    ../hardware/dynamic.nix
    ../modules/settings.nix
    ../services/vfio.nix
  ];

  networking.hostName = "neo";
}
