{
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  networking = {
    hostName = "vm";
  };

  profiles = {
    desktop = {
      enable = true;
      addons = {
        hyprland.enable = true;
      };
    };
  };

  system.stateVersion = "23.11";
}
