{ config, ... }: {

  # Hostname
  networking.hostName = "dozer";

  # DPI settings
  services.xserver.dpi = 109;

}
