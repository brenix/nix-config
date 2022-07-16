{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";

    autoRepeatDelay = 195;
    autoRepeatInterval = 15;

    displayManager = {
      defaultSession = "none+bspwm";
      autoLogin.enable = true;
      autoLogin.user = "brenix";
    };

    desktopManager.xterm.enable = false;

    windowManager = { bspwm.enable = true; };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        middleEmulation = false;
      };
    };

    xkbOptions = "caps:escape";
  };

  environment.systemPackages = with pkgs; [
    xorg.xdpyinfo
    xorg.xinit
    xclip
  ];
}
