{ config, ... }:
let
  devices = [
    { device = "10de:2206"; slot = "0b:00.0"; } # GPU
    { device = "10de:1aef"; slot = "0b:00.1"; } # GPU HD AUDIO
    { device = "8086:1539"; slot = "06:00.0"; } # I211 Gigabit Ethernet
  ];
in
{
  boot = {
    kernelParams = [
      "amd_iommu=on"
      "default_hugepagesz=1G"
      "hugepagesz=1G"
      "transparent_hugepage=never"
      "nohz_full=8-15,24-31"
      "rcu_nocbs=8-15,24-31"
      "iommu=pt"
      "rd.driver.pre=vfio-pci"
      "systemd.unified_cgroup_hierarchy=1"
      "usbcore.autosuspend=-1"
      "tsc=reliable"
      "mitigations=off"
      "module_blacklist=xhci_pci"
      "quiet"
      "video=efifb:off"
    ];
    blacklistedKernelModules = [ "snd_hda_intel" "nvidia" "nouveau" ];
    kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];

    extraModprobeConfig = ''
      options vfio-pci ids=${lib.concatMapStringsSep "," (d: d.device) devices}
      options kvm ignore_msrs=1
    '';
  };
}

  # Hostname
  networking.hostName = "neo";

# Enable DHCP
systemd.network.networks.enp7s0 = {
matchConfig = { Name = "enp7s0"; };
DHCP = "yes";
};

# DPI settings
services.xserver.dpi = 109;

# Fix scaling in GTK apps
environment.variables.GDK_SCALE = "1";
environment.variables.GDK_DPI_SCALE = "1";

# Configure host-specific settings
settings = { dpi = 109; };

# Pass settings to home-manager
home-manager.users.${config.settings.username}.settings = config.settings;


}
