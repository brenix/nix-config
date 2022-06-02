{ config, pkgs, ... }: {

  imports = [ ../hardware/vm-fusion.nix ];

  # Hostname
  networking.hostName = "tank";

  # DPI settings
  services.xserver.dpi = 180;
  hardware.video.hidpi.enable = true;

  # Fix alacritty font scaling on hidpi
  environment.variables.WINIT_X11_SCALE_FACTOR = "1.5";

  # Fix scaling in GTK apps
  environment.variables.GDK_SCALE = "2";
  environment.variables.GDK_DPI_SCALE = "0.5";

  # Pass settings to home-manager
  home-manager.users.brenix = {
    xsession.windowManager.bspwm.monitors = { Virtual-1 = [ "1" "2" "3" "4" ]; };

    programs.alacritty.settings.font.size = 16;
  };

}
