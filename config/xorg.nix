{ config, pkgs, ... }: {

  services.xserver = {
    enable = true;
    layout = "us";

    # Fast keyboard response
    autoRepeatDelay = 195;
    autoRepeatInterval = 15;

    # Disable lightdm and allow for startx
    displayManager = {
      startx.enable = true;
    };

    # Remap capslock to escape
    xkbOptions = "caps:escape";
  };

  environment.systemPackages = with pkgs; [
    xorg.xdpyinfo
  ];

}
