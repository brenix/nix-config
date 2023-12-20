{
  networking.firewall.enable = false;

  services.resolved = {
    enable = true;
    domains = [ "lan" ];
    dnssec = "false";
  };
}
