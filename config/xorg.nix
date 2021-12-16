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

    # Add openbox to lightdm sessions
    windowManager.openbox.enable = true;

    # Autologn
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = config.settings.username;

    # Remap capslock to escape
    xkbOptions = "caps:escape";
  };

  environment.systemPackages = with pkgs; [ xorg.xdpyinfo ];

}
