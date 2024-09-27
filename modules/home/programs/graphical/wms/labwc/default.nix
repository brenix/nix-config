{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.wms.labwc;
in {
  imports = lib.snowfall.fs.get-non-default-nix-files ./.;

  options.${namespace}.programs.graphical.wms.labwc = {
    enable = mkBoolOpt false "enable labwc window manager";
    swapCapsEsc = mkBoolOpt false "swap capslock with escape";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      labwc
      grimblast
      wl-clipboard
    ];

    programs.labwc = {
      enable = true;
      environment = {
        "XKB_DEFAULT_LAYOUT" = "us";
      };
      environment."XKB_DEFAULT_OPTIONS" = mkIf cfg.swapCapsEsc "caps:escape";
      config = {
        desktops = {
          number = 4;
        };

        focus = {
          followMouse = true;
          followMouseRequiresMovement = true;
          raiseOnFocus = true;
        };

        libinput.default = {
          accelProfile = "flat";
          naturalScroll = true;
          clickMethod = "clickFinger";
        };

        theme = {
          cornerRadius = 0;
        };

        windowRules = [
          {
            criteria.identifier = "alacritty";
            properties.serverDecoration = true;
          }
        ];
      };
    };

    ${namespace}.programs.graphical = {
      addons = {
        hyprpaper.enable = true;
        kanshi.enable = true;
        wlogout.enable = true;
        wlsunset.enable = false;
      };
      bars.yambar.enable = true;
      launchers.fuzzel.enable = true;
      notifications.fnott.enable = true;
    };
  };
}
