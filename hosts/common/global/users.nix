{ pkgs, config, lib, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.brenix = {
    hashedPasswordFile = config.sops.secrets.brenix-password.path;
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "audio"
      "input"
      "video"
      "wheel"
    ] ++ ifTheyExist [
      "i2c"
      "docker"
      "podman"
      "libvirtd"
      "kvm"
      "network"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F (none)"
    ];
    packages = [ pkgs.home-manager ];
  };

  sops.secrets.brenix-password = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  # Increase tmpfs storage for /run/user/<uid>
  services.logind.extraConfig = lib.mkDefault ''
    RuntimeDirectorySize=50%
  '';

  home-manager.users.brenix = import home/${config.networking.hostName}.nix;
}
