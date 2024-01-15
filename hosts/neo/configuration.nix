{ inputs, pkgs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    # ./disks.nix # TODO: uncomment during reinstall
    ./libvirt.nix
    ./mounts.nix # TODO: remove during reinstall

    ../../nixos/global
    ../../nixos/users/brenix.nix

    ../../nixos/optional/auto-login.nix
    ../../nixos/optional/clipcat.nix
    ../../nixos/optional/ephemeral.nix
    ../../nixos/optional/fonts.nix
    # ../../nixos/optional/gaming.nix
    ../../nixos/optional/openconnect.nix
    ../../nixos/optional/opengl.nix
    ../../nixos/optional/pipewire.nix
    ../../nixos/optional/podman.nix
    ../../nixos/optional/systemd-boot.nix
    ../../nixos/optional/xorg.nix
  ];

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [
      "tsc=reliable"
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
    initrd.kernelModules = [
      "amdgpu"
    ];
    kernelModules = [
      "dm-snapshot"
      "i2c-dev"
      "i2c-piix4"
      "k10temp"
      "kvm-amd"
    ];
    blacklistedKernelModules = [
      "sp5100_tco"
      "nouveau"
      "iwlwifi"
      "mac80211"
      "iTCO_wdt"
    ];
    extraModprobeConfig = ''
      options usbhid kbpoll=1
      options usbhid mousepoll=1
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
  environment.systemPackages = with pkgs; [
    aircrack-ng
    wordlists
  ];

  # Programs
  programs = {
    dconf.enable = true;
  };
  services.ratbagd.enable = true;

  # Xorg settings
  services.xserver.dpi = 108;
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --mode 2560x1440
    ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --mode 2560x1440
    ${pkgs.xorg.xset}/bin/xset s off -dpms
  '';

  # Swap
  swapDevices = [{ device = "/swap/swapfile"; }];

  system.stateVersion = "23.11";
}
