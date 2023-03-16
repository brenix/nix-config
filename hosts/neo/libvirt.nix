{ config, pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      runAsRoot = true;
      verbatimConfig = ''
        security_driver = "none"
        security_default_confined = 0
        seccomp_sandbox = 0
        user = "brenix"
        group = "kvm"
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
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-event-if04",
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-event-joystick",
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-if03-event-kbd",
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-if04-event-mouse",
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-if04-mouse",
          "/dev/input/by-id/usb-Wooting_Wooting_60HE__ARM__WOOT_001_A02B2305W052H07682-joystick",
        ]
      '';
    };
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  environment.systemPackages = with pkgs; [ virt-manager ];

  systemd.services.libvirtd = {
    # Libvirt hooks use binaries from these packages
    path =
      let
        env = pkgs.buildEnv {
          name = "qemu-hook-env";
          paths = with pkgs; [
            bash
            config.boot.kernelPackages.cpupower
            killall
            libvirt
            procps
            systemd
            util-linux
          ];
        };
      in
      [ env ];

    preStart = ''
      mkdir -p /var/lib/libvirt/hooks
      chmod 755 /var/lib/libvirt/hooks
      cp -f ${./qemu} /var/lib/libvirt/hooks/qemu
      chmod 755 /var/lib/libvirt/hooks/qemu
    '';
  };

  environment.persistence = {
    "/persist".directories = [
      "/var/lib/libvirt"
    ];
  };
}
