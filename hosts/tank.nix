{ config, pkgs, ... }:

{
  imports = [
    ../configuration.nix
    ../hardware/vm-fusion.nix
    ../modules/settings.nix
  ];

  settings = {
    vm = true;
  };

  # Set Hostname
  networking.hostName = "tank";

  # DPI settings
  services.xserver.dpi = 180;
  hardware.video.hidpi.enable = true;

  # Fix alacritty font scaling on hidpi
  environment.variables.WINIT_X11_SCALE_FACTOR = "1.5";

  # Fix scaling in GTK apps
  environment.variables.GDK_SCALE = "2";
  environment.variables.GDK_DPI_SCALE = "0.5";
}
