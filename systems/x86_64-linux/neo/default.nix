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

  hardware = {
    wootingKeyboard.enable = true;
    logitechMouse.enable = true;
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
      ];
      IOMMUType = "amd";
      devices = [
        "10de:2206" # RTX 3080
        "10de:1aef" # RTX 3080 HD Audio
        "8086:1539" # I211 Gigabit Ethernet
      ];
      disableEFIfb = true;
      blacklistNvidia = true;
      ignoreMSRs = true;
      hugepages = {
        enable = true;
        defaultPageSize = "1G";
        pageSize = "1G";
      };
    };
  };

  profiles = {
    desktop = {
      enable = true;
      addons = {
        hyprland.enable = true;
      };
    };
  };

  programs = {
    cli.go.enable = true;
    discord.enable = true;
    spotify.enable = true;
    vscode.enable = true;
  };

  networking.hostName = "neo";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "preempt=voluntary"
      "intremap=no_x2apic_optout"
      "transparent_hugepage=never"
      "nohz_full=8-15,24-31"
      "rcu_nocb_poll"
      "rcu_nocbs=8-15,24-31"
    ];
    extraModprobeConfig = ''
      options kvm halt_poll_ns=0
      options kvm nx_huge_pages=off
      # options kvm_amd avic=1
      # options kvm_amd force_avic=1
      options kvm_amd nested=0
      options kvm_amd npt=1
      options vfio_iommu_type1 allow_unsafe_interrupts=1
      options vfio_iommu_type1 disable_hugepages=0
    '';
  };

  system.stateVersion = "23.11";
}
