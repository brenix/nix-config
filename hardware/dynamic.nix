{ config, lib, pkgs, ... }: {

  /* imports = [ */
  /*   "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/cpu/amd" */
  /*   "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/gpu/nvidia" */
  /* ]; */

  # Enable DHCP
  networking.interfaces.enp7s0.useDHCP = true;
}
