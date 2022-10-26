# This file (and the global directory) holds config that i use on all hosts
{ pkgs, lib, inputs, hostname, persistence, config, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ./locale.nix
    ./nix.nix
    ./openssh.nix
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
    pciutils
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

  environment = {
    # Activate home-manager environment
    shellInit = ''
      [ -d "$HOME/.nix-profile" ] || /nix/var/nix/profiles/per-user/$USER/home-manager/activate &> /dev/null
    '';

    # Persist logs, timers, etc
    persistence = lib.mkIf persistence {
      "/persist".directories = [ "/var/lib/systemd" "/var/log" ];
      "/persist".files = [ "/etc/machine-id" ];
    };

    # Add terminfo files
    enableAllTerminfo = true;
  };

  # Allows users to allow others on their bind
  programs.fuse.userAllowOther = true;

  # Allow sudo without password if in wheel group
  security.sudo.wheelNeedsPassword = false;

  # Enable firmware and allow unfree pkgs
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  system.stateVersion = lib.mkDefault "22.05";
}
