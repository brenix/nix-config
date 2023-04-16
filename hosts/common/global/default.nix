# This file (and the global directory) holds config that i use on all hosts
{ pkgs, lib, inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./optin-persistence.nix
    ./sops.nix
    ./sysctl.nix
    ./users.nix
    ./zsh.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  # Networking
  networking.dhcpcd.enable = false;
  networking.firewall.enable = false;
  systemd.network.enable = true;
  services.resolved = {
    enable = true;
    dnssec = "false";
  };

  # Packages
  environment.systemPackages = with pkgs; [
    bash-completion
    curlie
    dig
    fd
    gcc
    gettext
    gnumake
    nmap
    pciutils
    ripgrep
    usbutils
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
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "75%";

  # Enable all terms
  environment.enableAllTerminfo = true;

  # Allow sudo without password if in wheel group
  security.sudo.wheelNeedsPassword = false;

  # Enable firmware and allow unfree pkgs
  hardware.enableRedistributableFirmware = true;
  nixpkgs = {
    config.allowUnfree = true;
    overlays = builtins.attrValues outputs.overlays;
  };

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

  system.stateVersion = lib.mkDefault "22.11";
}
