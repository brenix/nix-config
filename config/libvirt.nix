{ pkgs, ... }: {

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      runAsRoot = false;
      verbatimConfig = ''
        security_driver = "none"
        security_default_confined = 0
        seccomp_sandbox = 0
      '';
    };
  };

  environment.systemPackages = with pkgs; [ virt-manager win-virtio ];

  # TODO: libvirt-hooks
}
