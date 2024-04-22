{
  disko.devices = {
    disk = {
      disk0 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-Samsung_SSD_840_PRO_Series_S1ANNSAF710885R";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "boot";
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };

            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-L" "nixos" "-f" ];
                postCreateHook = ''
                  mount -t btrfs /dev/disk/by-label/nixos /mnt
                  btrfs subvolume snapshot -r /mnt /mnt/root-blank
                  umount /mnt
                '';
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [ "subvol=root" "compress=zstd" "autodefrag" "noatime" ];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [ "subvol=home" "compress=zstd" "autodefrag" "noatime" ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "subvol=nix" "compress=zstd" "autodefrag" "noatime" ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "subvol=persist" "compress=zstd" "autodefrag" "noatime" ];
                  };
                  "/swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = "8G";
                  };
                };
              };
            };
          };
        };
      };

      disk1 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WDC_WD1003FZEX-00MK2A0_WD-WCC3FKSNAE6K";
        content = {
          type = "gpt";
          partitions = {
            priimary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "data";
              };
            };
          };
        };
      };

      disk2 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WDC_WD1003FZEX-00MK2A0_WD-WCC3FNCUFPPL";
        content = {
          type = "gpt";
          partitions = {
            priimary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "data";
              };
            };
          };
        };
      };

      disk3 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-Corsair_Force_GT_122579040000150203D8";
        content = {
          type = "gpt";
          partitions = {
            priimary = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "xfs";
                mountpoint = "/var/lib/rancher/k3s/agent/containerd";
                mountOptions = [
                  "defaults"
                  "noatime"
                  "lazytime"
                ];
              };
            };
          };
        };
      };
    };

    lvm_vg = {
      data = {
        type = "lvm_vg";
        lvs = {
          config = {
            size = "100G";
            extraArgs = "--stripes 2 --stripesize 256k";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/config";
              mountOptions = [
                "defaults"
                "noatime"
              ];
            };
          };
          media = {
            size = "800G";
            extraArgs = "--stripes 2 --stripesize 256k";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/media";
              mountOptions = [
                "defaults"
                "noatime"
              ];
            };
          };
          nix-cache = {
            size = "30G";
            extraArgs = "--stripes 2 --stripesize 256k";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/var/cache/nginx";
              mountOptions = [
                "defaults"
                "noatime"
              ];
            };
          };
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
