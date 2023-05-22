{ lib, pkgs, ... }:
let
  devices = [
    # GPU
    {
      device = "10de:2206";
      slot = "0b:00.0";
    }
    # GPU AUDIO
    {
      device = "10de:1aef";
      slot = "0b:00.1";
    }
    # I211 Gigabit Ethernet
    {
      device = "8086:1539";
      slot = "06:00.0";
    }
  ];
in
{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "pci_stub"
      "sd_mod"
      "usb_storage"
      "usbhid"
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
      "xhci_pci"
    ];

    kernelModules = [
      "dm-snapshot"
      "i2c-dev"
      "i2c-piix4"
      "k10temp"
      "kvm-amd"
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
    ];

    blacklistedKernelModules = [
      "bluetooth"
      "btusb"
      "sp5100_tco"
      "nouveau"
      "iwlwifi"
      "mac80211"
      "iTCO_wdt"
    ];

    kernelParams = [
      "amd_iommu=on"
      "preempt=voluntary"
      "boot.shell_on_fail"
      "default_hugepagesz=1G"
      "hugepagesz=1G"
      "intremap=no_x2apic_optout"
      "iommu=pt"
      "mitigations=off"
      "nohz_full=8-15,24-31"
      "rcu_nocb_poll"
      "rcu_nocbs=8-15,24-31"
      "rd.driver.pre=vfio-pci"
      "systemd.unified_cgroup_hierarchy=1"
      "transparent_hugepage=never"
      "tsc=reliable"
      "usbcore.autosuspend=-1"
      "vfio-pci.ids=${lib.concatMapStringsSep "," (d: d.device) devices}"
      "video=efifb:off"
    ];

    extraModprobeConfig = ''
      options kvm halt_poll_ns=0
      options kvm ignore_msrs=1
      options kvm nx_huge_pages=off
      options kvm report_ignored_msrs=0
      options kvm_amd avic=1
      options kvm_amd force_avic=1
      options kvm_amd nested=0
      options kvm_amd npt=1
      options usbhid kbpoll=1
      options usbhid mousepoll=1
      options vfio-pci disable_vga=1
      options vfio_iommu_type1 allow_unsafe_interrupts=1
      options vfio_iommu_type1 disable_hugepages=0
      options nvidia NVreg_UsePageAttributeTable=1 NVreg_InitializeSystemMemoryAllocations=0 NVreg_DynamicPowerManagement=0x02
      options nvidia_drm modeset=1
    '';
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
  };

  systemd.mounts = [
    {
      what = "/dev/mapper/data-cache";
      where = "/home/brenix/.cache";
      type = "xfs";
      options = "rw,noatime,lazytime";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-work";
      where = "/home/brenix/work";
      type = "xfs";
      options = "rw,noatime,lazytime";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-downloads";
      where = "/home/brenix/downloads";
      type = "xfs";
      options = "rw,noatime,lazytime";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-containers";
      where = "/home/brenix/.containers";
      type = "xfs";
      options = "rw,noatime,lazytime";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  services.resolved.domains = [ "localdomain" ];

  services.udev.packages = [ pkgs.wooting-udev-rules ];

  systemd.network.networks.enp7s0 = {
    matchConfig = { Name = "enp7s0"; };
    DHCP = "yes";
    routes = [{
      routeConfig = {
        InitialCongestionWindow = 50;
        InitialAdvertisedReceiveWindow = 50;
      };
    }];
  };

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  nixpkgs.hostPlatform.system = "x86_64-linux";
}
