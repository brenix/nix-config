{ config, ... }: {

  imports = [ ../hardware/vm-qemu.nix ../modules/settings.nix ];

  # Hostname
  networking.hostName = "dozer";

  # DPI settings
  services.xserver.dpi = 109;

  # Fix scaling in GTK apps
  environment.variables.GDK_SCALE = "1";
  environment.variables.GDK_DPI_SCALE = "1";

  # Configure host-specific settings
  settings = { dpi = 109; };

  # Pass settings to home-manager
  home-manager.users.${config.settings.username} = {
    settings = config.settings;

    xsession.windowManager.bspwm.monitors = { Virtual1 = [ "1" "2" "3" "4" ]; };
  };
}
