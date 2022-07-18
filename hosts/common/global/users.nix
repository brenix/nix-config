{ pkgs, config, lib, persistence, ... }:
{
  users.mutableUsers = false;
  users.users = {
    brenix = {
      passwordFile = config.sops.secrets.brenix-password.path;
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "audio"
        "video"
        "wheel"
      ]
      # Add user to additional groups upon evaluating if they are enabled
      ++ (lib.optional config.hardware.i2c.enable "i2c")
      ++ (lib.optional config.virtualisation.docker.enable "docker")
      ++ (lib.optional config.virtualisation.podman.enable "podman")
      ++ (lib.optional config.virtualisation.libvirtd.enable "libvirtd")
      ++ (lib.optional config.virtualisation.libvirtd.enable "kvm");

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F (none)"
      ];
    };
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
