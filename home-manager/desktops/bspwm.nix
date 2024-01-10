{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.wms.bspwm;
in
{
  options.modules.wms.bspwm = {
    enable = mkEnableOption "enable bspwm window manager";
  };

  config = mkIf cfg.enable {
    xsession.windowManager.bspwm = {
      enable = true;

      settings = {
        remove_disabled_monitors = true;
        remove_unplugged_monitors = true;
        merge_overlapping_monitors = true;
        focus_follows_pointer = true;
        border_width = 2;
        window_gap = 10;
        automatic_scheme = "tiling";
        initial_polarity = "first_child";
        split_ratio = 0.52;
        borderless_monocle = true;
        single_monocle = true;
        gapless_monocle = false;
        click_to_focus = "button1";
        pointer_modifier = "mod4";
        pointer_action1 = "move";
        pointer_action2 = "resize_side";
        pointer_motion_interval = 5;
        normal_border_color = "#000000";
        active_border_color = "#000000";
        focused_border_color = "#555555";
        presel_feedback_color = "#131313";
      };

      startupPrograms = [
        "${pkgs.feh}/bin/feh --bg-scale ${config.my.settings.wallpaper}"
        "${pkgs.flameshot}/bin/flameshot"
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
        "Steam" = {
          state = "floating";
        };
        "steam" = {
          state = "floating";
        };
        "Alacritty:floating" = {
          state = "floating";
        };
        "st:floating" = {
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
        "nsxiv" = { state = "floating"; };
        "Pavucontrol" = { state = "floating"; };
      };
    };

    services.sxhkd = {
      enable = true;
      keybindings = {
        # reload config
        "super + Escape" = "pkill -USR1 -x sxhkd";

        # quit/restart
        "super + shift + {q,r}" = "bspc {quit,wm -r}";

        # close and kill window
        "super + {_,shift + }w" = "bspc node -{c,k}";

        # swap the current node and the biggest node
        "super + g" = "bspc node -s biggest";

        # set the window state
        "super + {t,shift + t,f,shift + f}" =
          "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

        # alternate between the tiled and monocle layout
        "super + shift + m" = "bspc desktop -l next";

        # set the node flags
        "super + ctrl + {m,x,y,z}" =
          "bspc node -g {marked,locked,sticky,private}";

        # focus the node in the given direction
        "super + {_,shift + }{h,j,k,l}" =
          "bspc node -{f,s} {west,south,north,east}";

        # focus the next/previous node in the current desktop
        "{super,alt} + {_,shift + }Tab" = "bspc node -f {next,prev}.local";

        # focus the last desktop
        "{super,alt} + grave" = "bspc desktop -f last";

        # cycle between desktops using arrow keys
        "super + {Left, Right}" = "bspc desktop -f {prev,next}.local";

        # focus or send to the given desktop
        "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";

        # change window gap
        "super + {minus,equal}" =
          "bspc config -d focused window_gap $((`bspc config -d focused window_gap` {+,-} 2 ))";

        # rotate
        "super + r" = "bspc node @/ -R 90";

        # preselect the direction
        "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";

        # preselect the ratio
        "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";

        # cancel the preselection for the focused node
        "super + ctrl + space" = "bspc node -p cancel";

        # cancel the preselection for the focused desktop
        "super + ctrl + shift + space" =
          "bspc query - N - d | xargs - I id - n 1 bspc node id - p cancel";

        # expand a window by moving one of its side outward
        "super + alt + { h, j, k, l }" =
          "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

        # contract a window by moving one of its side inward
        "super + alt + shift + {h,j,k,l}" =
          "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

        # move a floating window
        "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";

        # -- apps

        # terminal (tmux)
        "super + Return" = "alacritty";

        # terminal (floating)
        "super + shift + Return" = "alacritty --class Alacritty,floating";

        # launcher
        "{super,alt} + space" = "rofi -show run";

        # calculator
        "F1" = "rofi -show calc -modi calc --no-show-match --no-sort -lines 2";

        # emoji
        "F2" = "rofi -show emoji -modi emoji";

        # files
        "super + shift + p" = "pcmanfm";

        # browser
        # "super + d" =
        #   "${pkgs.xdotool}/bin/xdotool search Firefox windowactivate || firefox-beta";
        "super + d" = "chromium";

        # spotify
        "super + s" = if config.my.settings.dpi > 150 then "spotify --force-device-scale-factor=2" else "spotify";

        # slack
        "super + shift + s" = if config.my.settings.dpi > 150 then "slack --force-device-scale-factor=2" else "slack";

        # ncmpcpp
        "super + n" = "alacritty -e ncmpcpp";

        # discord
        "super + shift + d" = "discocss";

        # flameshot
        "Print" = "${pkgs.flameshot}/bin/flameshot gui";

        # obsidian
        "super + o" = "obsidian";

        # Focus primary slack channel
        "super + e" = "xdg-open 'slack://channel?team=T024JFTN4&id=GHMTDF91B'";

        # piper
        "super + p" = "piper";

        # zoom
        "super + z" = "zoom";

        # -- volume control

        # pavucontrol
        "super + v" = "pavucontrol";

        # volume up/down
        "{XF86AudioRaiseVolume, XF86AudioLowerVolume}" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%{+,-}";

        # mute
        "XF86AudioMute" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

        # next
        "XF86AudioNext" = "playerctl next";

        # prev
        "XF86AudioPrev" = "playerctl previous";

        # play/pause
        "XF86AudioPlay" = "playerctl play-pause";

        # stop
        "XF86AudioStop" = "playerctl stop";
      };

    };
  };
}
