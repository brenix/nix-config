{ lib, ... }: {
  # Disable firewall
  networking.firewall.enable = false;

  # Enable systemd-resolved
  services.resolved.enable = lib.mkDefault true;

  # NOTE: Disabled since it doesn't seem to help and borked k8s a bit
  #services.resolved.domains = [ "localdomain" ];

  # Enable systemd-networkd
  networking.dhcpcd.enable = false;
  systemd.network.enable = true;

  # Disable DNSSEC (for now)
  services.resolved.dnssec = "false";
}
