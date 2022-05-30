{ config, pkgs, lib, ... }:
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
  # Hostname
  networking.hostName = "neo";

  services.resolved.domains = [ "localdomain" ];

  # Enable DHCP
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

    kernelParams = [
      "amd_iommu=on"
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
    ];

    blacklistedKernelModules = [ "nouveau" ];

    kernelModules = [
      "dm-snapshot"
      "i2c-dev"
      "i2c-piix4"
      "kvm-amd"
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
      "vfio_virqfd"
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

  # Filesystems
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/46d2e29d-bdd3-4ad3-b907-41dc56058c9c";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "commit=60" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D346-5109";
    fsType = "vfat";
  };

  # Mounts
  systemd.mounts = [
    {
      what = "/dev/mapper/data-cache";
      where = "/home/brenix/.cache";
      type = "ext4";
      options = "rw,noatime,barrier=0";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-steam";
      where = "/home/brenix/.local/share/Steam/steamapps";
      type = "ext4";
      options = "rw,noatime,barrier=0";
      wantedBy = [ "multi-user.target" ];

    }
  ];

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl = {
    enable = true;
  };

  # I2C devices
  hardware.i2c.enable = true;

  # Enable all firmware
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  # VFIO input devices
  virtualisation.libvirtd.qemu.verbatimConfig = ''
    cgroup_device_acl = [
      "/dev/null", "/dev/full", "/dev/zero",
      "/dev/random", "/dev/urandom",
      "/dev/ptmx", "/dev/kvm",
      "/dev/vfio/vfio", "/dev/vfio/26", "/dev/vfio/28",
      "/dev/input/by-id/usb-Logitech_USB_Receiver-event-mouse",
      "/dev/input/by-id/usb-Logitech_USB_Receiver-if01-event-kbd",
      "/dev/input/by-id/usb-Logitech_USB_Receiver-mouse",
      "/dev/input/by-id/usb-Logitech_PRO_X_Wireless_DE1A8313-event-mouse",
      "/dev/input/by-id/usb-Logitech_PRO_X_Wireless_DE1A8313-if01-event-kbd",
      "/dev/input/by-id/usb-Logitech_PRO_X_Wireless_DE1A8313-mouse",
      "/dev/input/by-id/usb-Topre_REALFORCE_87_US-event-kbd",
    ]
  '';

  # Udev Rule for webcam
  services.udev.extraRules = ''
    SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTRS{product}=="HD Pro Webcam C920",RUN+="${pkgs.v4l-utils}/bin/v4l2-ctl -d $devnode --set-ctrl brightness=128,contrast=128,saturation=110,white_balance_automatic=0,gain=30,white_balance_temperature=3700,auto_exposure=1,exposure_time_absolute=777,focus_automatic_continuous=0,pan_absolute=0,zoom_absolute=120"
  '';

  # DPI settings
  services.xserver.dpi = 109;

  # Fix scaling in GTK apps
  environment.variables.GDK_SCALE = "1";
  environment.variables.GDK_DPI_SCALE = "1";

  # Set thermal path for polybar
  environment.variables.HWMON_PATH =
    "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon3/temp1_input";

  # Pass settings to home-manager
  home-manager.users.brenix = {
    xsession.windowManager.bspwm.monitors = {
      DP-4 = [ "1" "2" ];
      HDMI-0 = [ "3" "4" ];
    };

  };

}
