{ inputs, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export RADV_PERFTEST=aco
    export DXVK_ASYNC=1
    export PROTON_NO_ESYNC=1
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    export VK_LOADER_DRIVERS_SELECT=nvidia*
    exec "$@"
  '';
in
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd
    # ./disks.nix # TODO: uncomment during reinstall
    ./mounts.nix # TODO: remove during reinstall

    ../../nixos
    ../../nixos/users/brenix.nix
  ];

  modules.nixos = {
    avahi.enable = true;
    auto-login.enable = false;
    auto-upgrade.enable = false;
    clipcat.enable = false;
    ephemeral.enable = true;
    fonts.enable = true;
    gaming.enable = true;
    login.enable = true;
    openconnect.enable = true;
    opengl.enable = true;
    pipewire.enable = true;
    podman.enable = true;
    systemd-boot.enable = true;
    wireless.enable = false;
    xorg.enable = false;
  };

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [
      # "tsc=reliable"
      "usbcore.autosuspend=-1"
    ];
    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "sd_mod"
      "usb_storage"
      "usbhid"
      "xhci_pci"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [
      "dm-snapshot"
      "i2c-dev"
      "i2c-piix4"
      "k10temp"
      "kvm-amd"
    ];
    blacklistedKernelModules = [
      "sp5100_tco"
      "iwlwifi"
      "mac80211"
      "iTCO_wdt"
    ];
    extraModprobeConfig = ''
      options usbhid kbpoll=1
      options usbhid mousepoll=2
    '';
    postBootCommands = ''
      # Reset GPU due to bug with monitor
      echo 1 >/sys/devices/pci0000:00/0000:00:03.2/0000:0e:00.0/reset
    '';
  };

  # Networking
  networking = {
    hostName = "neo";
  };
  networking.useDHCP = pkgs.lib.mkForce false;
  networking.useNetworkd = false;

  systemd.network.enable = true;
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

  # Nix
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # Hardware-specific stuff
  services.udev.packages = [ pkgs.wooting-udev-rules ];
  hardware.nvidia = {
    prime = {
      amdgpuBusId = "PCI:13:0:0";
      nvidiaBusId = "PCI:14:0:0";
    };
  };

  environment.systemPackages = [ nvidia-offload ];

  # Programs
  programs = {
    dconf.enable = true;
  };

  # Xorg settings
  # services.xserver.dpi = 108;
  # services.xserver.displayManager.sessionCommands = ''
  #   ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --mode 2560x1440
  #   ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --mode 2560x1440
  #   ${pkgs.xorg.xset}/bin/xset s off -dpms
  # '';

  # Swap
  swapDevices = [{ device = "/swap/swapfile"; }];

  system.stateVersion = "23.11";
}
