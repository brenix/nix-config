{
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
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
                extraArgs = ["-L" "nixos" "-f"];
                postCreateHook = ''
                  mount -t btrfs /dev/disk/by-label/nixos /mnt
                  btrfs subvolume snapshot -r /mnt /mnt/root-blank
                  umount /mnt
                '';
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = ["subvol=root" "compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["subvol=nix" "compress=zstd" "noatime"];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["subvol=persist" "compress=zstd" "noatime"];
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

      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            priimary = {
              label = "linux";
              size = "250G";
              content = {
                type = "lvm_pv";
                vg = "data";
              };
            };
            # primary = {
            #   label = "windows";
            #   size = "100%";
            #   content = {
            #     type = "ntfs";
            #   };
            # };
          };
        };
      };
    };

    lvm_vg = {
      data = {
        type = "lvm_vg";
        lvs = {
          cache = {
            size = "50G";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/home/brenix/.cache";
              mountOptions = [
                "defaults"
                "noatime"
                "lazytime"
              ];
            };
          };
          containers = {
            size = "50G";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/home/brenix/.containers";
              mountOptions = [
                "defaults"
                "noatime"
                "lazytime"
              ];
            };
          };
          downloads = {
            size = "50G";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/home/brenix/downloads";
              mountOptions = [
                "defaults"
                "noatime"
                "lazytime"
              ];
            };
          };
          work = {
            size = "20G";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/home/brenix/work";
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

  fileSystems."/persist".neededForBoot = true;
}
