{ config, pkgs, ... }: {

  imports = [ ../modules/settings.nix ];

  services.xserver = {
    enable = true;
    layout = "us";

    # Fast keyboard response
    autoRepeatDelay = 195;
    autoRepeatInterval = 15;

    displayManager = {
      defaultSession = "none+openbox";
      autoLogin.enable = true;
      autoLogin.user = config.settings.username;
    };

    desktopManager.xterm.enable = false;

    windowManager = { openbox.enable = true; };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        middleEmulation = false;
      };
    };

    # Remap capslock to escape
    xkbOptions = "caps:escape";
  };

  environment.systemPackages = with pkgs; [ xorg.xdpyinfo ];

}
