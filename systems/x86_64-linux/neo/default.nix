{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix

    ./libvirt-hook
  ];

  matrix = {
    hardware = {
      wooting.enable = true;
    };

    services = {
      virtualisation.podman.enable = true;
      virtualisation.vfio = {
        enable = true;
        libvirtd.deviceACL = [
          "/dev/input/by-id/usb-Logitech_USB_Receiver-event-mouse"
          "/dev/input/by-id/usb-Logitech_USB_Receiver-if01-event-kbd"
          "/dev/input/by-id/usb-Logitech_USB_Receiver-mouse"
          "/dev/input/by-id/usb-Logitech_PRO_X_Wireless_DE1A8313-event-mouse"
          "/dev/input/by-id/usb-Logitech_PRO_X_Wireless_DE1A8313-if01-event-kbd"
          "/dev/input/by-id/usb-Logitech_PRO_X_Wireless_DE1A8313-mouse"
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-event-if04"
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-event-joystick"
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-if03-event-kbd"
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-if04-event-mouse"
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-if04-mouse"
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-joystick"
          "/dev/input/by-id/usb-Beijing_Jingyunmake_Technology_Co.__Ltd._G-Wolves_HSK_Pro_Receiver-N_ADC2149E82440365-mouse"
          "/dev/input/by-id/usb-Beijing_Jingyunmake_Technology_Co.__Ltd._G-Wolves_HSK_Pro_Receiver-N_ADC2149E82440365-event-if01"
          "/dev/input/by-id/usb-Beijing_Jingyunmake_Technology_Co.__Ltd._G-Wolves_HSK_Pro_Receiver-N_ADC2149E82440365-if01-event-kbd"
          "/dev/input/by-id/usb-Beijing_Jingyunmake_Technology_Co.__Ltd._G-Wolves_HSK_Pro_Receiver-N_ADC2149E82440365-event-mouse"
        ];
        IOMMUType = "amd";
        devices = [
          "10de:2206" # RTX 3080
          "10de:1aef" # RTX 3080 HD Audio
          "8086:1539" # I211 Gigabit Ethernet
        ];
        disableEFIfb = false;
        blacklistNvidia = true;
        ignoreMSRs = true;
        hugepages = {
          enable = true;
          defaultPageSize = "1G";
          pageSize = "1G";
        };
      };
    };

    roles = {
      desktop = {
        enable = true;
        addons = {
          labwc.enable = true;
        };
      };
    };
  };

  networking.hostName = "neo";
  networking.nameservers = ["192.168.1.1"];
  networking.interfaces.enp7s0.ipv4.addresses = [
    {
      address = "192.168.1.9";
      prefixLength = 24;
    }
  ];
  networking.interfaces.enp7s0.ipv4.routes = [
    {
      address = "0.0.0.0";
      prefixLength = 0;
      via = "192.168.1.1";
      options = {
        quickack = "1";
        initcwnd = "50";
        initrwnd = "50";
        fastopen_no_cookie = "1";
      };
    }
  ];

  boot = {
    blacklistedKernelModules = [
      # Blacklist the AMD Ryzen SP5100 TCO Watchdog/Timer module
      "sp5100_tco"
    ];
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [
      "preempt=voluntary"
      "intremap=no_x2apic_optout"
      "transparent_hugepage=never"
      "nohz_full=8-15,24-31"
      "rcu_nocb_poll"
      "rcu_nocbs=8-15,24-31"
      "usbcore.autosuspend=-1"
      "nvme_core.default_ps_max_latency_us=0"
    ];
    extraModprobeConfig = ''
      options usbhid kbpoll=1
      options usbhid mousepoll=2
      options kvm halt_poll_ns=0
      options kvm nx_huge_pages=off
      # options kvm_amd avic=1
      # options kvm_amd force_avic=1
      options kvm_amd nested=0
      options kvm_amd npt=1
      options vfio_iommu_type1 allow_unsafe_interrupts=1
      options vfio_iommu_type1 disable_hugepages=0
    '';
    postBootCommands = ''
      # Reset GPU
      echo 1 >/sys/devices/pci0000:00/0000:00:03.2/0000:0e:00.0/reset
    '';
  };

  system.stateVersion = "23.11";
}
