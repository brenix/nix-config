{ config, ... }: {

  # Hostname
  networking.hostName = "neo";

  # Enable DHCP
  systemd.network.networks.enp7s0 = {
    matchConfig = {
      Name = "enp7s0";
    };
    DHCP = "yes";
  };

  # DPI settings
  services.xserver.dpi = 109;

  # Fix scaling in GTK apps
  environment.variables.GDK_SCALE = "1";
  environment.variables.GDK_DPI_SCALE = "1";

  # Configure host-specific settings
  settings = {
    dpi = 109;
  };

  # Pass settings to home-manager
  home-manager.users.${config.settings.username}.settings = config.settings;

  # -- VFIO

  #let
  #  devices = [
  #    { device = "10de:1c82"; slot = "42:00.0"; } # GPU
  #    { device = "10de:0fb9"; slot = "42:00.1"; } # GPU audio controller
  #    # USB controllers
  #    { device = "1022:43ba"; slot = "01:00.0"; }
  #    { device = "1022:145c"; slot = "08:00.3"; }
  #    { device = "1022:145c"; slot = "43:00.3"; }
  #  ];
  #in {
  #  boot = {
  #    kernelParams = [ "amd_iommu=on" "module_blacklist=xhci_pci" "quiet" "video=efifb:off" ];
  #    blacklistedKernelModules = [ "snd_hda_intel" "nvidia" "nouveau" ];
  #    kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];

  #    extraModprobeConfig = ''
  #      options vfio-pci ids=${lib.concatMapStringsSep "," (d: d.device) devices}
  #      options kvm ignore_msrs=1
  #    '';
  #  };
  #}


}
