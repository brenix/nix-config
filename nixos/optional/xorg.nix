{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.modules.nixos.xorg;
in
{
  options.modules.nixos.xorg = {
    enable = mkEnableOption "Enable X11";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb.layout = "us";

      autoRepeatDelay = 195;
      autoRepeatInterval = 30;

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
    };

    environment.systemPackages = with pkgs; [
      xorg.xdpyinfo
      xorg.xinit
      xclip
    ];
  };
}
