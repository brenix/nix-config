{ config, pkgs, ... }: {

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      runAsRoot = true;
      verbatimConfig = ''
        security_driver = "none"
        security_default_confined = 0
        seccomp_sandbox = 0
      '';
    };
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  environment.systemPackages = with pkgs; [ virt-manager win-virtio ];

  systemd.services.libvirtd = {
    # Libvirt hooks use binaries from these packages
    path =
      let
        env = pkgs.buildEnv {
          name = "qemu-hook-env";
          paths = with pkgs; [
            bash
            config.boot.kernelPackages.cpupower
            ddcutil
            killall
            libvirt
            procps
            systemd
            util-linux
          ];
        };
        # TODO: pass host cpu/hardware specs here?
      in
      [ env ];

    preStart = ''
      mkdir -p /var/lib/libvirt/hooks
      chmod 755 /var/lib/libvirt/hooks
      ln -sf ${./qemu} /var/lib/libvirt/hooks/qemu
    '';
  };
}
