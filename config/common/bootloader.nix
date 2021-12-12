{ pkgs, lib, ... }: {

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    cleanTmpDir = true;

    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = true;
      efi.canTouchEfiVariables = true;
    };
  };

}
