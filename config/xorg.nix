{ config, pkgs, ... }: {

  imports = [ ../modules/settings.nix ];

  services.xserver = {
    enable = true;
    layout = "us";

    # Fast keyboard response
    autoRepeatDelay = 195;
    autoRepeatInterval = 15;

    # Disable lightdm and allow for startx
    #displayManager = {
    #  startx.enable = true;
    #};

    displayManager.defaultSession = "none+bspwm";

    windowManager.openbox.enable = true;
    windowManager.bspwm.enable = true;

    # Autologn
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = config.settings.username;

    # Remap capslock to escape
    xkbOptions = "caps:escape";
  };

  environment.systemPackages = with pkgs; [ xorg.xdpyinfo ];

}
