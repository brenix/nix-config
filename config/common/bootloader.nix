{ pkgs, lib, ... }: {

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    cleanTmpDir = true;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 256;
      systemd-boot.consoleMode = "max";
      systemd-boot.editor = true;
      systemd-boot.enable = true;
      timeout = 2;
    };
  };

}
