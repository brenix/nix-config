{ config, pkgs, lib, ... }: {

  boot = {
    # Default to mainline kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    # Delete all files in `/tmp/` during boot
    cleanTmpDir = true;

    # Use systemd-boot bootloader
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = true;
      efi.canTouchEfiVariables = true;
    };
  };

}
