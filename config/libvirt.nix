{ config, ... }: {

  imports = [ ../modules/settings.nix ];

  virtualisation.libvirtd = {
    enable = true;
    enableKVM = true;
    qemu = {
      ovmf.enable = true;
      runAsRoot = false;
      verbatimConfig = ''
        security_driver = "none"
        security_default_confined = 0
        user = ${config.settings.username}
        seccomp_sandbox = 0
      '';
    };
  };

  # TODO: libvirt-hooks
}
