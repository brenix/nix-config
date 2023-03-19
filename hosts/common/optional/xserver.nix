{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";

    autoRepeatDelay = 215;
    autoRepeatInterval = 30;

    displayManager = {
      defaultSession = "none+openbox";
      autoLogin.enable = true;
      autoLogin.user = "brenix";
    };

    desktopManager.xterm.enable = false;

    # windowManager = { bspwm.enable = true; };
    windowManager = { openbox.enable = true; };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        middleEmulation = false;
      };
    };

    # xkbOptions = "caps:escape";
  };

  environment.systemPackages = with pkgs; [
    xorg.xdpyinfo
    xorg.xinit
    xclip
  ];
}
