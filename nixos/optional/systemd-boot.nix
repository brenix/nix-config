{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      systemd-boot.editor = true;
      systemd-boot.consoleMode = "max";
    };
  };
}
