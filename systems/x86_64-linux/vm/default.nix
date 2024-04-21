{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "vm";
  };

  profiles = {
    desktop.enable = true;
    desktop.addons.gnome.enable = true;
  };

  system.stateVersion = "23.11";
}
