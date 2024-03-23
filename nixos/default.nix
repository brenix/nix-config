{ lib, inputs, outputs, pkgs, ... }:
{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.disko.nixosModules.disko
      inputs.chaotic.nixosModules.default

      ./ananicy.nix
      ./locale.nix
      ./network.nix
      ./nix.nix
      ./openssh.nix
      ./pam.nix
      ./persistence.nix
      ./sops.nix
      ./sysctl.nix

      ./optional/auto-login.nix
      ./optional/auto-upgrade.nix
      ./optional/avahi.nix
      ./optional/clipcat.nix
      ./optional/ephemeral.nix
      ./optional/fonts.nix
      ./optional/gaming.nix
      ./optional/greetd.nix
      ./optional/node-exporter.nix
      ./optional/openconnect.nix
      ./optional/opengl.nix
      ./optional/pipewire.nix
      ./optional/podman.nix
      ./optional/qemu-guest.nix
      ./optional/syncthing.nix
      ./optional/systemd-boot.nix
      ./optional/vmware-guest.nix
      ./optional/wireless.nix
      ./optional/xorg.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  # Configure home-manager
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  # Enable redistributable firmware
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  # Allow sudo without password if in wheel group
  security.sudo.wheelNeedsPassword = false;

  # Enable some common services
  services.bpftune.enable = true;
  services.dbus.enable = true;
  services.fwupd.enable = true;
  services.geoclue2.enable = true;
  # services.udisks2.enable = true;

  # https://discourse.nixos.org/t/boot-faster-by-disabling-udev-settle-and-nm-wait-online/6339
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Optimize interrupt frequency
  systemd.services."optimize-rtc-interrupt" = {
    description = "Increase the highest requested RTC interrupt frequency";
    serviceConfig = {
      type = "oneshot";
    };
    script = ''
      ${pkgs.bash}/bin/bash -c 'echo 3072 > /sys/class/rtc/rtc0/max_user_freq'
      ${pkgs.bash}/bin/bash -c 'echo 3072 > /proc/sys/dev/hpet/max-user-freq'
    '';
    wantedBy = [ "multi-user.target" ];
  };

  # Limit journald retention
  services.journald.extraConfig = lib.mkDefault ''
    MaxLevelStore=info
    MaxRetentionSec=1week
  '';

  # Disable mitigatons for performance
  boot.kernelParams = [
    "mitigations=off"
  ];

  # Put tmp on tmpfs
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "75%";

  # Link common shells
  environment.pathsToLink = [
    "/share/fish"
    "/share/bash"
  ];

  # Enable all terms
  environment.enableAllTerminfo = true;

  # Configure nixpkgs
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      joypixels.acceptLicense = true;
    };
  };

  # Install common packages
  environment.systemPackages = with pkgs; [
    bash-completion
    curlie
    dig
    fd
    gcc
    gettext
    gnumake
    nmap
    pciutils
    ripgrep
    usbutils
    xfsprogs
    scx # Perhaps needed by bpftune?
  ];

  # Toggle some features for chaotic flake
  chaotic.mesa-git.enable = false;
  chaotic.appmenu-gtk3-module.enable = false;
  chaotic.nyx.overlay.enable = true;
}
