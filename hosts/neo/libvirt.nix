{ pkgs, lib, ... }:
let
  devices = [
    # GPU
    {
      device = "10de:2206";
      slot = "0b:00.0";
    }
    # GPU AUDIO
    {
      device = "10de:1aef";
      slot = "0b:00.1";
    }
    # I211 Gigabit Ethernet
    {
      device = "8086:1539";
      slot = "06:00.0";
    }
  ];
in
{
  boot = {
    initrd.availableKernelModules = [
      "pci_stub"
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
    ];
    kernelModules = [
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
    ];
    kernelParams = [
      "amd_iommu=on"
      "preempt=voluntary"
      "default_hugepagesz=1G"
      "hugepagesz=1G"
      "intremap=no_x2apic_optout"
      "iommu=pt"
      "nohz_full=8-15,24-31"
      "rcu_nocb_poll"
      "rcu_nocbs=8-15,24-31"
      "rd.driver.pre=vfio-pci"
      "transparent_hugepage=never"
      "vfio-pci.ids=${lib.concatMapStringsSep "," (d: d.device) devices}"
      "video=efifb:off"
    ];
    extraModprobeConfig = ''
      options kvm halt_poll_ns=0
      options kvm ignore_msrs=1
      options kvm nx_huge_pages=off
      options kvm report_ignored_msrs=0
      # options kvm_amd avic=1
      # options kvm_amd force_avic=1
      options kvm_amd nested=0
      options kvm_amd npt=1
      options vfio-pci disable_vga=1
      options vfio_iommu_type1 allow_unsafe_interrupts=1
      options vfio_iommu_type1 disable_hugepages=0
    '';
  };
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      # Don't hook evdev at vm start
      # package = pkgs.qemu_kvm.overrideAttrs (old: {
      #   patches =
      #     old.patches
      #     ++ [
      #       (pkgs.writeText "qemu.diff" ''
      #         diff --git a/ui/input-linux.c b/ui/input-linux.c
      #         index e572a2e..a9d76ba 100644
      #         --- a/ui/input-linux.c
      #         +++ b/ui/input-linux.c
      #         @@ -397,12 +397,6 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
      #              }

      #              qemu_set_fd_handler(il->fd, input_linux_event, NULL, il);
      #         -    if (il->keycount) {
      #         -        /* delay grab until all keys are released */
      #         -        il->grab_request = true;
      #         -    } else {
      #         -        input_linux_toggle_grab(il);
      #         -    }
      #              QTAILQ_INSERT_TAIL(&inputs, il, next);
      #              il->initialized = true;
      #              return;
      #       '')
      #     ];
      #   # buildInputs = old.buildInputs ++ [ pkgs.pipewire ];
      #   # configureFlags = old.configureFlags ++ [ "--enable-pipewire" ];
      # });
      ovmf.enable = true;
      runAsRoot = true;
      verbatimConfig = ''
        user = "brenix"
        group = "kvm"
        namespaces = []
        security_driver = []
        security_default_confined = 0
        seccomp_sandbox = 0
        cgroup_device_acl = [
          "/dev/null", "/dev/full", "/dev/zero",
          "/dev/random", "/dev/urandom",
          "/dev/ptmx", "/dev/kvm",
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
