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
          "/dev/input/by-id/usb-04d9_USB_Keyboard-event-kbd",
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
