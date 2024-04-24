{pkgs, ...}: {
  systemd.services.libvirtd = {
    # Libvirt hooks use binaries from these packages
    path = let
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
    in [env];

    preStart = ''
      mkdir -p /var/lib/libvirt/hooks
      chmod 755 /var/lib/libvirt/hooks
      cp -f ${./qemu.sh} /var/lib/libvirt/hooks/qemu
      chmod 755 /var/lib/libvirt/hooks/qemu
    '';
  };
}
