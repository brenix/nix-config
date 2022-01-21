{ config, pkgs, ... }: {

  boot = {
    # Needed to install bootloader
    loader.systemd-boot.graceful = true;
    initrd = {
      availableKernelModules =
        [ "ahci" "xhci_pci" "ehci_pci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-intel" ];
  };

  # Hostname
  networking.hostName = "trinity";

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

  # Filesystems
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5796da76-5092-4278-bdbd-2b7a65317407";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D891-9B3F";
    fsType = "vfat";
  };

  # Mounts
  systemd.mounts = [
    {
      what = "/dev/mapper/data-config";
      where = "/config";
      type = "ext4";
      options = "rw,noatime,barrier=0";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "/dev/mapper/data-downloads";
      where = "/downloads";
      type = "ext4";
      options = "rw,noatime,barrier=0";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  # Reduce loggin
  services.journald.extraConfig = ''
    MaxLevelStore=info
    MaxRetentionSec=3day
  '';

  # Kubernetes
  environment.systemPackages = with pkgs; [ helm helmfile kubectl kubernetes ];

  networking.extraHosts = "192.168.1.10 api.kubernetes";

  services.kubernetes = {
    roles = [ "master" "node" ];

    apiserverAddress = "https://api.kubernetes:6443";
    apiserver.advertiseAddress = "192.168.1.10";
    masterAddress = "api.kubernetes";

    # Enable feature gates
    featureGates = [ "MixedProtocolLBService" ];

    # Allow privileged pods
    apiserver.allowPrivileged = true;

    # Additional apiserver flags
    apiserver.extraOpts =
      "--permit-port-sharing=true --permit-address-sharing=true";

    # Disable addon manager
    addonManager.enable = false;

    # Use cloudflare certmgr to manage all certs
    easyCerts = true;

    # Kubelet
    kubelet.extraOpts =
      "--resolv-conf=/run/systemd/resolve/resolv.conf --fail-swap-on=false";
  };

  # Duplicati
  services.duplicati = {
    enable = true;
    interface = "any";
  };

  # Create k8s@home user/group
  users.users.kah = {
    uid = 568;
    group = "kah";
    isNormalUser = true;
    createHome = false;
  };

  users.groups.kah = { gid = 568; };

  # Enable all firmware
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  home-manager.users.${config.settings.username} = {
    settings = config.settings;
  };

}
