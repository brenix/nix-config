{ pkgs, ... }: {

  imports = [ ../../modules/settings.nix ]

  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {
      config.settings.monitor = [ "1" "2" "3" "4" ];
    };

    settings = {
      remove_disabled_monitors = true;
      remove_unplugged_monitors = true;
      merge_overlapping_monitors = true;
      focus_follows_pointer = true;
      border_width = 3;
      window_gap = 1;
      automatic_scheme = spiral;
      initial_polarity = first_child;
      split_ratio = 0.52;
      borderless_monocle = true;
      single_monocle = true;
      gapless_monocle = false;
      click_to_focus = button1;
      pointer_modifier = mod4;
      pointer_action1 = move;
      pointer_action2 = resize_side;
      pointer_motion_interval = 7;
    };

    startupPrograms = [
      "sxhkd"
    ];

    rules = {
      "Authy" = {
        state = "floating";
        follow = true;
        focus = true;
      };
      "Spotify" = {
        desktop = "^3";
      };
      "Pavucontrol" = {
        state = "floating";
      };
      "Slack" = {
        desktop = "^2";
      };
      "sxiv" = {
        state = "floating";
      };
      "zoom" = {
        state = "floating";
        sticky = true;
      };
      "mpv" = {
        state = "floating";
        sticky = true;
      };
  };



}
