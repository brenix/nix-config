{ config, ... }: {

  # Hostname
  networking.hostName = "trinity";

  # Enable DHCP
  systemd.network.networks.enp7s0 = {
    matchConfig = {
      Name = "enp7s0";
    };
    DHCP = "yes";
  };

}
