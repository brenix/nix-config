{ config, pkgs, ... }: {


  environment.pathsToLink = [ "/share/zsh" ];

  users.users.brenix = {
    isNormalUser = true;
    createHome = true;
    home = "/home/brenix";
    extraGroups = [ "adbusers" "i2c" "input" "kvm" "libvirtd" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F 20170524-brenix@gmail.com"
    ];
  };

}
