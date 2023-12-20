{ config, pkgs, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  home-manager.users.brenix = import ../../hosts/${config.networking.hostName}/home.nix;

  users.mutableUsers = false;
  users.users.brenix = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "audio"
      "input"
      "video"
      "wheel"
    ] ++ ifTheyExist [
      "docker"
      "git"
      "i2c"
      "kvm"
      "libvirtd"
      "network"
      "networkmanager"
      "plugdev"
      "podman"
      "tss"
      "wireshark"
    ];

    openssh.authorizedKeys.keys = [ (builtins.readFile ./brenix.pub) ];
    hashedPasswordFile = config.sops.secrets.defaultPassword.path;
    packages = [ pkgs.home-manager ];
  };

  sops.secrets.defaultPassword = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  programs.fish.enable = true;
}
