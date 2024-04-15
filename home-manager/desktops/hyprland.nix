{ inputs, config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.wms.hyprland;
in
{
  options.modules.wms.hyprland = {
    enable = mkEnableOption "enable hyprland window manager";
  };

  config = mkIf cfg.enable {

    home.sessionVariables = {
      LIBSEAT_BACKEND = "logind";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
    };

    home.packages = [
      inputs.hyprwm-contrib.packages.${pkgs.system}.grimblast
      pkgs.wl-clipboard
    ];

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        monitor = eDP-1,highres,auto,1
        monitor = DP-1,highrr,auto,1
        monitor = HDMI-A-1,highrr,auto,1
        input {
          # kb_options = caps:swapescape
          repeat_rate = 45
          repeat_delay = 280
          accel_profile = flat
          follow_mouse = 1
          touchpad {
            disable_while_typing = false
            natural_scroll = true
          }
        }

        general {
          gaps_in = 5
          gaps_out = 10
          border_size = 1
          col.active_border = 0xff${config.colorscheme.palette.base03}
          col.inactive_border = 0xff${config.colorscheme.palette.base01}
        }

        decoration {
          rounding = 0
          blur {
            enabled = false
          }
          drop_shadow = false
        }

        animations {
          enabled = false
        }

        misc {
          disable_hyprland_logo = 1
          force_default_wallpaper = 0
        }

        env = QT_QPA_PLATFORM,wayland
        env = QT_QPA_PLATFORMTHEME,qt6ct
        env = HYPRCURSOR_SIZE,32


        exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once = ${pkgs.waybar}/bin/waybar &
        exec-once = ${pkgs.swaybg}/bin/swaybg -i ${config.my.settings.wallpaper} --mode fill &

        windowrulev2 = idleinhibit focus,class:^(mpv)$
        windowrulev2 = idleinhibit fullscreen,class:^(firefox)$
        windowrulev2 = float,class:^(pavucontrol)$
        windowrulev2 = float,class:^(zoom)$
        windowrulev2 = float,class:^(Bitwarden)$,title:^(Bitwarden).*$
        windowrulev2 = float,class:^(steam)$

        bind = SUPER,Return,exec,${config.my.settings.default.terminal}
        bind = SUPERSHIFT,Return,exec,[floating] ${config.my.settings.default.terminal}
        bind = SUPER,Space,exec,${config.my.settings.default.launcher} --show run
        bind = SUPER,d,exec,${config.my.settings.default.browser}
        bind = SUPER,c,exec,codium
        bind = SUPER,s,exec,spotify
        bind = SUPERSHIFT,s,exec,slack
        bind = SUPER,v,exec,pavucontrol
        bind = SUPERSHIFT,q,exit

        bind = ,Print,exec,grimblast --notify copysave area
        bind = SHIFT,Print,exec,grimblast --notify copy active
        bind = CONTROL,Print,exec,grimblast --notify copy screen
        bind = SUPER,Print,exec,grimblast --notify copy window
        bind = ALT,Print,exec,grimblast --notify copy area
        bind = SUPER,bracketleft,exec,grimblast --notify --cursor copysave area ~/$(date "+%Y-%m-%d"T"%H:%M:%S_no_watermark").png
        bind = SUPER,bracketright,exec,grimblast --notify --cursor copy area
        bind = ,XF86MonBrightnessUp,exec,brightnessctl set 5%+
        bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
        bind = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
        bind = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
        bind = ,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        bind = ,XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_INPUT_SOURCE@ toggle
        bind = ,XF86AudioNext,exec,playerctl next
        bind = ,XF86AudioPrev,exec,playerctl previous
        bind = ,XF86AudioPlay,exec,playerctl play-pause
        bind = ,XF86AudioStop,exec,playerctl stop
        bind = ALT,XF86AudioNext,exec,playerctld shift
        bind = ALT,XF86AudioPrev,exec,playerctld unshift
        bind = ALT,XF86AudioPlay,exec,systemctl --user restart playerctld

        bind=SUPER,h,movefocus,l
        bind=SUPER,l,movefocus,r
        bind=SUPER,k,movefocus,u
        bind=SUPER,j,movefocus,d

        bind=SUPERSHIFT,h,swapwindow,l
        bind=SUPERSHIFT,l,swapwindow,r
        bind=SUPERSHIFT,k,swapwindow,u
        bind=SUPERSHIFT,j,swapwindow,d

        bind=SUPERCONTROL,h,focusmonitor,l
        bind=SUPERCONTROL,l,focusmonitor,r
        bind=SUPERCONTROL,k,focusmonitor,u
        bind=SUPERCONTROL,j,focusmonitor,d

        bind=SUPERALT,h,movecurrentworkspacetomonitor,l
        bind=SUPERALT,l,movecurrentworkspacetomonitor,r
        bind=SUPERALT,k,movecurrentworkspacetomonitor,u
        bind=SUPERALT,j,movecurrentworkspacetomonitor,d

        bind=SUPER,1,workspace,01
        bind=SUPER,2,workspace,02
        bind=SUPER,3,workspace,03
        bind=SUPER,4,workspace,04
        bind=SUPER,5,workspace,05
        bind=SUPER,6,workspace,06
        bind=SUPER,7,workspace,07
        bind=SUPER,8,workspace,08
        bind=SUPER,9,workspace,09
        bind=SUPER,0,workspace,10

        bind=SUPERSHIFT,1,movetoworkspacesilent,01
        bind=SUPERSHIFT,2,movetoworkspacesilent,02
        bind=SUPERSHIFT,3,movetoworkspacesilent,03
        bind=SUPERSHIFT,4,movetoworkspacesilent,04
        bind=SUPERSHIFT,5,movetoworkspacesilent,05
        bind=SUPERSHIFT,6,movetoworkspacesilent,06
        bind=SUPERSHIFT,7,movetoworkspacesilent,07
        bind=SUPERSHIFT,8,movetoworkspacesilent,08
        bind=SUPERSHIFT,9,movetoworkspacesilent,09
        bind=SUPERSHIFT,0,movetoworkspacesilent,10

        bind=ALTCTRL,L,movewindow,r
        bind=ALTCTRL,H,movewindow,l
        bind=ALTCTRL,K,movewindow,u
        bind=ALTCTRL,J,movewindow,d

        bind = SUPER, W, killactive,
        bind = SUPERSHIFT, F, fullscreen, 0
        bind = SUPER, F, togglefloating,

        bindm=SUPER, mouse:272, movewindow
        bindm=SUPER, mouse:273, resizewindow

        binde = SUPERALT, h, resizeactive, -20 0
        binde = SUPERALT, l, resizeactive, 20 0
        binde = SUPERALT, k, resizeactive, 0 -20
        binde = SUPERALT, j, resizeactive, 0 20
      '';
    };
  };
}
