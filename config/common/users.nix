{ config, pkgs, ... }: {

  imports = [ ../../modules/settings.nix ];

  environment.pathsToLink = [ "/share/zsh" ];

  users.users.${config.settings.username} = {
    isNormalUser = true;
    createHome = true;
    home = "/home/${config.settings.username}";
    description = config.settings.name;
    extraGroups =
      [ "input" "kvm" "libvirtd" "polkituser" "qemu-libvirtd" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F 20170524-brenix@gmail.com"
    ];
  };

}
