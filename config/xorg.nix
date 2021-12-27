{ config, pkgs, ... }: {

  imports = [ ../modules/settings.nix ];

  services.xserver = {
    enable = true;
    layout = "us";

    # Fast keyboard response
    autoRepeatDelay = 195;
    autoRepeatInterval = 15;

    displayManager = {
      defaultSession = "none+bspwm";
      autoLogin.enable = true;
      autoLogin.user = config.settings.username;
    };

    windowManager = { bspwm.enable = true; };

    libinput = {
      enable = true;
      mouse = { accelProfile = "flat"; };
    };

    # Remap capslock to escape
    xkbOptions = "caps:escape";
  };

  environment.systemPackages = with pkgs; [ xorg.xdpyinfo ];

}
