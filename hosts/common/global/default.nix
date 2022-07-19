# This file (and the global directory) holds config that i use on all hosts
{ pkgs, lib, inputs, hostname, persistence, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./peerix.nix
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
    gettext
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

  environment = {
    # Activate home-manager environment
    shellInit = ''
      [ -d "$HOME/.nix-profile" ] || /nix/var/nix/profiles/per-user/$USER/home-manager/activate &> /dev/null
    '';

    # Persist logs, timers, etc
    persistence = lib.mkIf persistence {
      "/persist".directories = [ "/var/lib/systemd" "/var/log" ];
    };

    # Add terminfo files
    enableAllTerminfo = true;
  };

  # Allows users to allow others on their bind
  programs.fuse.userAllowOther = true;

  # Enable firmware and allow unfree pkgs
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = lib.mkDefault "22.05";
}
