{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.lib.stylix) colors;

  cfg = config.${namespace}.programs.graphical.wms.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;

      # TODO: Results in home-manager switch failing due to unable to connect to hyprctl socket
      reloadConfig = false;

      systemdIntegration = true;
      recommendedEnvironment = true;
      xwayland.enable = true;

      config = {
        input = {
          kb_options = mkIf cfg.swapCapsEsc "caps:swapescape";
          kb_layout = "us";
          repeat_rate = 45;
          repeat_delay = 280;
          accel_profile = "flat";
          touchpad = {
            disable_while_typing = false;
            natural_scroll = true;
          };
        };

        workspace = [
          "1, persistent:true"
          "2, persistent:true"
          "3, persistent:true"
          "4, persistent:true"
        ];

        general = {
          gaps_in = 3;
          gaps_out = 10;
          border_size = 1;
          active_border_color = "0xff${colors.base03-hex}";
          inactive_border_color = "0xff${colors.base01-hex}";
        };

        decoration = {
          rounding = 0;
          blur.enabled = false;
        };

        animations.enabled = false;

        misc = let
          FULLSCREEN_ONLY = 2;
        in {
          vrr = 2;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          force_default_wallpaper = 0;
          variable_framerate = true;
          variable_refresh = FULLSCREEN_ONLY;
          disable_autoreload = true;
          # background_color = "0xff${colors.base00-hex}";
        };

        exec_once = [
          "dbus-update-activation-environment --systemd --all"
          "systemctl --user import-environment QT_QPA_PLATFORMTHEME"
          "${pkgs.kanshi}/bin/kanshi"
          # "${pkgs.yambar}/bin/yambar"
          "${pkgs.waybar}/bin/waybar"
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        ];
      };
    };
  };
}
