{config, ...}: {
  cli.programs.git = {
    allowedSigners = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F";
  };

  profiles = {
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
