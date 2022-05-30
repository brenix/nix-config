{ config, ... }: {

  # Hostname
  networking.hostName = "dozer";

  # DPI settings
  services.xserver.dpi = 109;

  # Fix scaling in GTK apps
  environment.variables.GDK_SCALE = "1";
  environment.variables.GDK_DPI_SCALE = "1";

  # Pass settings to home-manager
  home-manager.users.brenix = {
    xsession.windowManager.bspwm.monitors = { Virtual1 = [ "1" "2" "3" "4" ]; };
  };
}
