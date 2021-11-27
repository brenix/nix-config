/* let */
/*   devices = [ */
/*     { device = "10de:1c82"; slot = "42:00.0"; } # GPU */
/*     { device = "10de:0fb9"; slot = "42:00.1"; } # GPU audio controller */
/*     # USB controllers */
/*     { device = "1022:43ba"; slot = "01:00.0"; } */
/*     { device = "1022:145c"; slot = "08:00.3"; } */
/*     { device = "1022:145c"; slot = "43:00.3"; } */
/*   ]; */
/* in { */
/*   boot = { */
/*     kernelParams = [ "amd_iommu=on" "module_blacklist=xhci_pci" "quiet" "video=efifb:off" ]; */
/*     blacklistedKernelModules = [ "snd_hda_intel" "nvidia" "nouveau" ]; */
/*     kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ]; */
/*  */
/*     extraModprobeConfig = '' */
/*       options vfio-pci ids=${lib.concatMapStringsSep "," (d: d.device) devices} */
/*       options kvm ignore_msrs=1 */
/*     ''; */
/*   }; */
/* } */

{ config, lib, pkgs, ... }: {
  import = [
    ../modules/settings.nix
  ];

  users.users.${config.settings.username}.extraGroups = [ "libvirtd" ];

  virtualisation.libvirtd = {
    enable = true;
    enableKVM = true;
  };
}
