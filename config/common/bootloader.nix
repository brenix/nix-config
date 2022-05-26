{ pkgs, lib, ... }: {

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    cleanTmpDir = true;
    tmpOnTmpfs = true;
    tmpOnTmpfsSize = "75%";

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
      systemd-boot.consoleMode = "max";
      systemd-boot.editor = true;
      systemd-boot.enable = true;
      timeout = 2;
    };
  };

}
