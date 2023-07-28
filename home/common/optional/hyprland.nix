{ inputs, lib, config, pkgs, ... }: {

  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
  ];

  wayland.windowManager.hyprland =
    let
      inherit (config.colorscheme) colors;
      mako = "${pkgs.mako}/bin/mako";
      swaybg = "${pkgs.swaybg}/bin/swaybg";
    in
    {
      enable = true;
      package = pkgs.hyprland;
      extraConfig = (builtins.concatStringsSep "\n" (lib.forEach config.monitors (m: ''
        monitor=${m.name},${toString m.width}x${toString m.height}@${toString m.refreshRate},${toString m.x}x${toString m.y},${if m.enabled then "1" else "0"}
        ${lib.optionalString (m.workspace != null)"workspace=${m.name},${m.workspace}"}
      ''))) +
      ''
        env = WLR_DRM_DEVICES,/dev/dri/card0
      
        general {
          gaps_in=10
          gaps_out=10
          border_size=2
          col.active_border=0xff${colors.base03}
          col.inactive_border=0xff${colors.base02}
          col.group_border_active=0xff${colors.base0B}
          col.group_border=0xff${colors.base04}
          cursor_inactive_timeout=4
        }

        decoration {
          active_opacity=1.0
          inactive_opacity=1.0
          fullscreen_opacity=1.0
          rounding=0
          blur=false
          blur_size=6
          blur_passes=3
          blur_new_optimizations=true
          blur_ignore_opacity=true
          drop_shadow=true
          shadow_range=12
          shadow_offset=3 3
          col.shadow=0x44000000
          col.shadow_inactive=0x66000000
        }

        animations {
          enabled=false

          bezier=easein,0.11, 0, 0.5, 0
          bezier=easeout,0.5, 1, 0.89, 1
          bezier=easeinout,0.45, 0, 0.55, 1

          animation=windowsIn,1,3,easeout,slide
          animation=windowsOut,1,3,easein,slide
          animation=windowsMove,1,3,easeout

          animation=fadeIn,1,3,easeout
          animation=fadeOut,1,3,easein
          animation=fadeSwitch,1,3,easeout
          animation=fadeShadow,1,3,easeout
          animation=fadeDim,1,3,easeout
          animation=border,1,3,easeout

          animation=workspaces,1,2,easeout,slide
        }

        dwindle {
          split_width_multiplier=1.35
        }

        misc {
          vfr=on
        }

        input {
          kb_layout=us
          repeat_rate=50
          repeat_delay=195
          force_no_accel=1
          sensitivity=0
        }

        # Startup
        exec-once=waybar
        exec-once=${mako}
        exec=${swaybg} -c "#333333"

        # Rules
        windowrule=float,title:.*Zoom.*
        windowrule=float,title:.*zoom.*
        windowrule=float,title:Chat
        windowrule=float,foot:floating
        windowrule=float,pavucontrol

        # Mouse binding
        bindm=SUPER,mouse:272,movewindow
        bindm=SUPER,mouse:273,resizewindow

        # Program bindings
        bind=SUPER,Return,exec,foot
        bind=SUPERSHIFT,Return,exec,foot -a foot:floating
        bind=SUPER,Space,exec,wofi -S run
        bind=SUPER,d,exec,firefox
        bind=SUPER,o,exec,obsidian
        bind=SUPER,s,exec,spotify
        bind=SUPERSHIFT,s,exec,slack
        bind=SUPER,v,exec,pavucontrol
        bind=SUPERCONTROL,s,exec,spotify
        bind=SUPERSHIFT,d,exec,discord
        bind=SUPER,e,exec,xdg-open 'slack://channel?team=T024JFTN4&id=GHMTDF91B'

        # Screenshots
        bind=,Print,exec,grimblast --notify copy area
        bind=SHIFT,Print,exec,grimblast --notify copy active
        bind=CONTROL,Print,exec,grimblast --notify copy screen
        bind=SUPER,Print,exec,grimblast --notify copy window
        bind=ALT,Print,exec,grimblast --notify copy output

        # Audio
        bind=,XF86AudioNext,exec,playerctl next
        bind=,XF86AudioPrev,exec,playerctl previous
        bind=,XF86AudioPlay,exec,playerctl play-pause
        bind=,XF86AudioStop,exec,playerctl stop
        bind=,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
        bind=,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
        bind=,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

        # Window manager controls
        bind=SUPER,w,killactive,
        bind=SUPERSHIFT,e,exit,

        bind=SUPER,r,togglesplit,
        bind=SUPER,f,togglefloating,
        bind=SUPERSHIFT,f,fullscreen,0

        bind=SUPER,minus,splitratio,-0.25
        bind=SUPERSHIFT,minus,splitratio,-0.3333333

        bind=SUPER,equal,splitratio,0.25
        bind=SUPERSHIFT,equal,splitratio,0.3333333

        bind=SUPER,g,togglegroup
        bind=SUPER,apostrophe,changegroupactive,f
        bind=SUPERSHIFT,apostrophe,changegroupactive,b

        bind=SUPER,left,movefocus,l
        bind=SUPER,right,movefocus,r
        bind=SUPER,up,movefocus,u
        bind=SUPER,down,movefocus,d
        bind=SUPER,h,movefocus,l
        bind=SUPER,l,movefocus,r
        bind=SUPER,k,movefocus,u
        bind=SUPER,j,movefocus,d

        bind=SUPERSHIFT,left,movewindow,l
        bind=SUPERSHIFT,right,movewindow,r
        bind=SUPERSHIFT,up,movewindow,u
        bind=SUPERSHIFT,down,movewindow,d
        bind=SUPERSHIFT,h,movewindow,l
        bind=SUPERSHIFT,l,movewindow,r
        bind=SUPERSHIFT,k,movewindow,u
        bind=SUPERSHIFT,j,movewindow,d

        bind=SUPERCONTROL,left,focusmonitor,l
        bind=SUPERCONTROL,right,focusmonitor,r
        bind=SUPERCONTROL,up,focusmonitor,u
        bind=SUPERCONTROL,down,focusmonitor,d
        bind=SUPERCONTROL,h,focusmonitor,l
        bind=SUPERCONTROL,l,focusmonitor,r
        bind=SUPERCONTROL,k,focusmonitor,u
        bind=SUPERCONTROL,j,focusmonitor,d

        bind=SUPERCONTROL,1,focusmonitor,DP-1
        bind=SUPERCONTROL,2,focusmonitor,HDMI-A-1

        bind=SUPERCONTROLSHIFT,left,movewindow,mon:l
        bind=SUPERCONTROLSHIFT,right,movewindow,mon:r
        bind=SUPERCONTROLSHIFT,up,movewindow,mon:u
        bind=SUPERCONTROLSHIFT,down,movewindow,mon:d
        bind=SUPERCONTROLSHIFT,h,movewindow,mon:l
        bind=SUPERCONTROLSHIFT,l,movewindow,mon:r
        bind=SUPERCONTROLSHIFT,k,movewindow,mon:u
        bind=SUPERCONTROLSHIFT,j,movewindow,mon:d

        bind=SUPERCONTROLSHIFT,1,movewindow,mon:DP-1
        bind=SUPERCONTROLSHIFT,2,movewindow,mon:HDMI-A-1

        bind=SUPERALT,left,movecurrentworkspacetomonitor,l
        bind=SUPERALT,right,movecurrentworkspacetomonitor,r
        bind=SUPERALT,up,movecurrentworkspacetomonitor,u
        bind=SUPERALT,down,movecurrentworkspacetomonitor,d
        bind=SUPERALT,h,movecurrentworkspacetomonitor,l
        bind=SUPERALT,l,movecurrentworkspacetomonitor,r
        bind=SUPERALT,k,movecurrentworkspacetomonitor,u
        bind=SUPERALT,j,movecurrentworkspacetomonitor,d

        bind=SUPER,u,togglespecialworkspace,
        bind=SUPERSHIFT,u,movetoworkspace,special

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

        blurls=waybar
      '';
    };
}
