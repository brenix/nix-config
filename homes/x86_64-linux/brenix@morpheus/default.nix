{lib, ...}: {
  roles = {
    desktop.enable = true;
  };

  desktops.hyprland.enable = true;
  desktops.hyprland.swapCapsEsc = true;

  matrix.user = {
    enable = true;
    name = "brenix";
  };

  home.stateVersion = "23.11";
}
