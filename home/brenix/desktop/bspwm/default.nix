{ config, pkgs, primaryDisplay, secondaryDisplay, ... }:

let
  monitors =
    if primaryDisplay != null then
      if secondaryDisplay != null then
        {
          ${primaryDisplay} = [ "1" "2" ];
          ${secondaryDisplay} = [ "3" "4" ];
        }
      else
        {
          ${primaryDisplay} = [ "1" "2" "3" "4" ];
        }
    else
      { };
in
{
  imports = [
    ../common
    ../common/xorg-wm
    ./sxhkd.nix
  ];

  xsession.windowManager.bspwm = {
    enable = true;

    inherit monitors;

    settings = {
      remove_disabled_monitors = true;
      remove_unplugged_monitors = true;
      merge_overlapping_monitors = true;
      focus_follows_pointer = true;
      border_width = 1;
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
      normal_border_color = "#${config.colorscheme.colors.base00}";
      active_border_color = "#${config.colorscheme.colors.base00}";
      focused_border_color = "#${config.colorscheme.colors.base01}";
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
      "Alacritty:floating" = {
        state = "floating";
      };
      "zoom" = {
        state = "floating";
        sticky = true;
      };
      ".zoom " = {
        state = "floating";
        sticky = true;
      };
      "join*" = {
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
