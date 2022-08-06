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
    ../common/optional/btrfs-optin-persistence.nix
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
      "vfio_virqfd"
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
      "vfio_virqfd"
    ];

    kernelParams = [
      "amd_iommu=on"
      "boot.shell_on_fail"
      "default_hugepagesz=1G"
      "hugepagesz=1G"
      /* "hugepages=16" */
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
    ];

    extraModprobeConfig = ''
      options kvm halt_poll_ns=80000
      options kvm ignore_msrs=1
      options kvm nx_huge_pages=off
      options kvm report_ignored_msrs=0
      options kvm_amd avic=0
      options kvm_amd nested=0
      options kvm_amd npt=1
      options usbhid kbpoll=1
      options usbhid mousepoll=1
      options vfio-pci disable_vga=1
      options vfio_iommu_type1 allow_unsafe_interrupts=1
      options vfio_iommu_type1 disable_hugepages=0
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
      type = "ext4";
      options = "rw,noatime,barrier=0";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  services.resolved.domains = [ "localdomain" ];

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

  services.udev.extraRules = ''
    # Configure webcam parameters
    SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTRS{product}=="HD Pro Webcam C920",RUN+="${pkgs.v4l-utils}/bin/v4l2-ctl -d $devnode --set-ctrl brightness=128,contrast=128,saturation=110,white_balance_automatic=0,gain=30,white_balance_temperature=3700,auto_exposure=1,exposure_time_absolute=777,focus_automatic_continuous=0,pan_absolute=0,zoom_absolute=120"
    # Fix flickering issues
    SUBSYSTEM=="drm", KERNEL=="card0", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"
  '';

}
