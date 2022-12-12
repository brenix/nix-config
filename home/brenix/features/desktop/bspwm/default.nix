{ config, pkgs, ... }:

{
  imports = [
    ../common
    ../common/xorg-wm
    ./sxhkd.nix
  ];

  xsession.windowManager.bspwm = {
    enable = true;

    settings = {
      remove_disabled_monitors = true;
      remove_unplugged_monitors = true;
      merge_overlapping_monitors = true;
      focus_follows_pointer = true;
      border_width = 2;
      window_gap = 13;
      automatic_scheme = "floating";
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
      normal_border_color = "#${config.colorscheme.colors.base01}";
      active_border_color = "#${config.colorscheme.colors.base02}";
      focused_border_color = "#${config.colorscheme.colors.base02}";
      presel_feedback_color = "#${config.colorscheme.colors.base01}";
    };

    startupPrograms = [
      "${pkgs.feh}/bin/feh --bg-scale ${config.wallpaper}"
      "${pkgs.systemd}/bin/systemctl --user restart polybar.service"
    ];

    rules = {
      "Authy" = {
        state = "floating";
        follow = true;
        focus = true;
      };
      "firefox" = {
        desktop = "^3";
        focus = true;
      };
      "spotify" = {
        desktop = "^4";
        focus = true;
      };
      "Slack" = {
        desktop = "^2";
        focus = true;
      };
      "Alacritty:floating" = {
        state = "floating";
      };
      "zoom" = {
        state = "floating";
        sticky = true;
      };
      ".zoom " = {
        state = "floating";
      };
      "join*" = {
        state = "floating";
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
