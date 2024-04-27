{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.services.virtualisation.kvm;
in {
  options.services.virtualisation.kvm = {
    enable = lib.mkEnableOption "Enable kvm virtualisation";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libguestfs
      win-virtio
      win-spice
      virt-manager
      virt-viewer
    ];

    environment.persist.directories = [
      "/var/lib/libvirt"
    ];

    virtualisation = {
      spiceUSBRedirection.enable = true;

      libvirtd = {
        enable = true;
        allowedBridges = [
          "nm-bridge"
          "virbr0"
        ];
        onBoot = "ignore";
        onShutdown = "shutdown";
        qemu = {
          # Don't hook evdev at vm start
          package = pkgs.qemu_kvm.overrideAttrs (old: {
            patches =
              old.patches
              ++ [
                (pkgs.writeText "qemu.diff" ''
                  diff --git a/ui/input-linux.c b/ui/input-linux.c
                  index e572a2e..a9d76ba 100644
                  --- a/ui/input-linux.c
                  +++ b/ui/input-linux.c
                  @@ -397,12 +397,6 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
                       }

                       qemu_set_fd_handler(il->fd, input_linux_event, NULL, il);
                  -    if (il->keycount) {
                  -        /* delay grab until all keys are released */
                  -        il->grab_request = true;
                  -    } else {
                  -        input_linux_toggle_grab(il);
                  -    }
                       QTAILQ_INSERT_TAIL(&inputs, il, next);
                       il->initialized = true;
                       return;
                '')
              ];
          });
          # Purposely set runAsRoot to true, as the user/group will be overwritten via the vfio module
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };
        };
      };
    };
  };
}
