{ pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix
    ../common/global
    ../common/optional/ananicy.nix
    ../common/optional/auto-hibernate.nix
    ../common/optional/clipcat.nix
    ../common/optional/fonts.nix
    ../common/optional/openconnect.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/wireless.nix
    ../common/optional/xserver.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [
      # "mem_sleep_default=deep"
      "nvme.noacpi=1"
      # "btusb.enable_autosuspend=n"
      # "resume_offset=11019520" # btrfs inspect-internal map-swapfile -r /swap/swapfile
    ];

    blacklistedKernelModules = [ "hid-sensor-hub" ];
    resumeDevice = "/dev/disk/by-label/morpheus";
  };

  networking.hostName = "morpheus";
  networking.useDHCP = lib.mkDefault true;

  services.fwupd.enable = true;
  services.resolved.domains = [ "lan" ];
  services.geoclue2.enable = true;

  environment.systemPackages = with pkgs; [
    framework-tool
  ];

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";
  services.power-profiles-daemon.enable = true;

  programs = {
    dconf.enable = true;
  };

  services.xserver.dpi = 123;
  services.xserver.xkbOptions = "caps:escape";
  services.xserver.libinput.touchpad.clickMethod = "clickfinger";
  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.xserver.libinput.touchpad.accelSpeed = "1.1";

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl0", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="amdgpu_bl0", ATTR{brightness}="55"
  '';

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  # };

  system.stateVersion = "23.11";
}
