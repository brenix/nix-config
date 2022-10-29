{ pkgs, config, lib, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.brenix = {
    passwordFile = config.sops.secrets.brenix-password.path;
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "video"
      "wheel"
    ] ++ ifTheyExist [
      "i2c"
      "docker"
      "podman"
      "libvirtd"
      "kvm"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F (none)"
    ];
  };

  sops.secrets.brenix-password = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  # Increase tmpfs storage for /run/user/<uid>
  services.logind.extraConfig = lib.mkDefault ''
    RuntimeDirectorySize=50%
  '';
}
