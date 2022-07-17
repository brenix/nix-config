# This file (and the global directory) holds config that i use on all hosts
{ pkgs, lib, inputs, hostname, ... }:
{
  imports = [
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./peerix.nix
    ./persist.nix
    ./sops.nix
    ./sysctl.nix
    ./users.nix
    ./zsh.nix
  ];

  # Networking
  networking.dhcpcd.enable = false;
  networking.firewall.enable = false;
  networking.hostName = hostname;
  systemd.network.enable = true;
  services.resolved = {
    enable = true;
    dnssec = "false";
  };

  # Packages
  environment.systemPackages = with pkgs; [
    bash-completion
    bat
    curlie
    dig
    fd
    gcc
    gnumake
    lsof
    nmap
    ripgrep
    tcpdump
  ];

  # https://discourse.nixos.org/t/boot-faster-by-disabling-udev-settle-and-nm-wait-online/6339
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Limit journald
  services.journald.extraConfig = lib.mkDefault ''
    MaxLevelStore=info
    MaxRetentionSec=1week
  '';

  # tmp on tmpfs
  boot.tmpOnTmpfs = true;
  boot.tmpOnTmpfsSize = "75%";

  # Add each flake input as a registry
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

  # Activate home-manager environment, if not already
  environment.loginShellInit = ''
    [ -d "$HOME/.nix-profile" ] || /nix/var/nix/profiles/per-user/$USER/home-manager/activate &> /dev/null
  '';

  hardware.enableRedistributableFirmware = true;
  # boot.initrd.systemd.enable = true;

  system.stateVersion = lib.mkDefault "22.05";
}
