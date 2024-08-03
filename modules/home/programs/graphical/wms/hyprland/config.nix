{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

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

        general = {
          gaps_in = 3;
          gaps_out = 5;
          border_size = 1;
          # active_border_color = "0xff${palette.base03}";
          # inactive_border_color = "0xff${palette.base01}";
        };

        decoration = {
          rounding = 0;
          blur.enabled = false;
          drop_shadow = false;
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
        };

        exec_once = [
          "dbus-update-activation-environment --systemd --all"
          "systemctl --user import-environment QT_QPA_PLATFORMTHEME"
          "${pkgs.kanshi}/bin/kanshi"
          "${pkgs.waybar}/bin/waybar"
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        ];
      };
    };
  };
}
