{ inputs, pkgs, lib, ... }: {
  imports = [
    inputs.hardware.nixosModules.framework-13-7040-amd
    ./disks.nix
    ./wireguard.nix

    ../../nixos
    ../../nixos/users/brenix.nix
  ];

  modules.nixos = {
    avahi.enable = true;
    auto-login.enable = false;
    auto-upgrade.enable = false;
    clipcat.enable = true;
    ephemeral.enable = true;
    fonts.enable = true;
    gaming.enable = false;
    login.enable = true;
    openconnect.enable = true;
    opengl.enable = true;
    pipewire.enable = true;
    podman.enable = true;
    systemd-boot.enable = true;
    wireless.enable = true;
    xorg.enable = false;
  };

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [
      "amd_pstate=active"
      "pcie_aspm=force"
      "pc"
      "ie_aspm.policy=powersupersave"
      "resume_offset=533760" # btrfs inspect-internal map-swapfile -r /swap/swapfile
    ];
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    blacklistedKernelModules = [
      # "hid-sensor-hub"
    ];
    extraModprobeConfig = ''
    '';
    resumeDevice = "/dev/disk/by-label/nixos";
  };

  # Networking
  networking = {
    hostName = "morpheus";
    useDHCP = lib.mkDefault true;
  };

  # Nix
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # Hardware-specific stuff
  environment.systemPackages = with pkgs; [
    # framework-tool

    # Wifi security testing
    aircrack-ng
    # wordlists
  ];
  hardware.framework.amd-7040.preventWakeOnAC = true; # https://www.phoronix.com/news/Framework-13-AMD-Lid-Suspend
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl0", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="amdgpu_bl0", ATTR{brightness}="55"
  '';

  # Power management
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  # Programs
  programs = {
    dconf.enable = true;
    light.enable = true; # For controlling backlight
  };

  # Use actkbd for brightness controls
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };

  # Xorg settings
  # services.xserver.dpi = 123;
  # services.xserver.xkb.options = "caps:escape";
  # services.xserver.libinput.touchpad.clickMethod = "clickfinger";
  # services.xserver.libinput.touchpad.naturalScrolling = true;
  # services.xserver.libinput.touchpad.accelSpeed = "1.1";

  # Swap
  swapDevices = [{ device = "/swap/swapfile"; }];

  system.stateVersion = "23.11";
}
