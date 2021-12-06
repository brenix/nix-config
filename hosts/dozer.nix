{ config, ... }: {

  imports = [
    ../hardware/vm-qemu.nix
  ];

  # Hostname
  networking.hostName = "dozer";

  # DPI settings
  services.xserver.dpi = 109;

  # Fix scaling in GTK apps
  environment.variables.GDK_SCALE = "1";
  environment.variables.GDK_DPI_SCALE = "1";

}
