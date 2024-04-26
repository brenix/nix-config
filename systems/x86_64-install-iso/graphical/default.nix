{lib, ...}: {
  networking.wireless.enable = lib.mkForce false;

  profiles = {
    desktop.enable = true;
    desktop.addons.gnome.enable = true;
  };

  system.stateVersion = "23.11";
}
