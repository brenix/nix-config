{ config, pkgs, ... }: {

  imports = [ ../../modules/settings.nix ];

  xsession.windowManager.bspwm = {
    enable = true;

    monitors = { ${config.settings.monitor} = [ "1" "2" "3" "4" ]; };

    settings = {
      remove_disabled_monitors = true;
      remove_unplugged_monitors = true;
      merge_overlapping_monitors = true;
      focus_follows_pointer = true;
      border_width = 3;
      window_gap = 1;
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
      pointer_motion_interval = 7;
      normal_border_color = "#${config.colorscheme.colors.base00}";
      active_border_color = "#${config.colorscheme.colors.base00}";
      focused_border_color = "#${config.colorscheme.colors.base03}";
      presel_feedback_color = "#${config.colorscheme.colors.base01}";
    };

    # HACK: Figure out solution for the need to restart polybar
    startupPrograms = [
      "${pkgs.feh}/bin/feh --no-fehbg --bg-scale $HOME/.background-image"
      "${pkgs.systemd}/bin/systemctl --user restart polybar.service"
    ];

    rules = {
      "Authy" = {
        state = "floating";
        follow = true;
        focus = true;
      };
      "Firefox" = { desktop = "^2"; };
      "Spotify" = { desktop = "^4"; };
      "Pavucontrol" = { state = "floating"; };
      "Slack" = { desktop = "^3"; };
      "sxiv" = { state = "floating"; };
      "zoom" = {
        state = "floating";
        sticky = true;
      };
      "mpv" = {
        state = "floating";
        sticky = true;
      };
    };
  };
}
