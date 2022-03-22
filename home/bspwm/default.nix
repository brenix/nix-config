{ config, pkgs, ... }: {

  imports = [ ../../modules/settings.nix ];

  xsession.windowManager.bspwm = {
    enable = true;

    settings = {
      remove_disabled_monitors = true;
      remove_unplugged_monitors = true;
      merge_overlapping_monitors = true;
      focus_follows_pointer = true;
      border_width = 3;
      window_gap = 10;
      automatic_scheme = "spiral";
      initial_polarity = "first_child";
      split_ratio = 0.52;
      borderless_monocle = true;
      single_monocle = true;
      gapless_monocle = false;
      click_to_focus = "button1";
      pointer_modifier = "mod4";
      pointer_action1 = "move";
      pointer_action2 = "resize_side";
      pointer_motion_interval = 6;
      normal_border_color = "#${config.colorscheme.colors.base00}";
      active_border_color = "#${config.colorscheme.colors.base00}";
      focused_border_color = "#${config.colorscheme.colors.base03}";
      presel_feedback_color = "#${config.colorscheme.colors.base01}";
    };

    startupPrograms = [
      "${pkgs.xorg.xsetroot}/bin/xsetroot -solid '#2d2f38'"
      "${pkgs.systemd}/bin/systemctl --user restart polybar.service"
    ];

    rules = {
      "Authy" = {
        state = "floating";
        follow = true;
        focus = true;
      };
      "Firefox" = {
        desktop = "^3";
        focus = true;
      };
      "Spotify" = {
        desktop = "^4";
        focus = true;
      };
      "Slack" = {
        desktop = "^2";
        focus = true;
      };
      "zoom" = {
        state = "floating";
        sticky = true;
      };
      "mpv" = {
        state = "floating";
        sticky = true;
      };
      "sxiv" = { state = "floating"; };
      "Pavucontrol" = { state = "floating"; };
    };
  };
}
