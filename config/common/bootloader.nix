{ pkgs, lib, ... }: {

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelPatches = [
      {
        name = "add-tcp-collapse";
        patch = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/cloudflare/linux/master/patches/0014-add-a-sysctl-to-enable-disable-tcp_collapse-logic.patch";
          sha256 = "18gkxhdv7xac2xibr78flvlklv287x35ax3lrbipr5kf2sh4jww7";
        };
      }
    ];

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
