{ config, pkgs, ... }: {

  import = [
    ../modules/settings.nix
  ];

  users.users.${config.settings.username}.extraGroups = [ "libvirtd" ];

  virtualisation.libvirtd = {
    enable = true;
    enableKVM = true;
  };

}
