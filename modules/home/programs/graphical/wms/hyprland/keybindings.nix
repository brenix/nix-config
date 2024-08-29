{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.${namespace}.programs.graphical.wms.hyprland;
  laptop_lid_switch = pkgs.writeShellScriptBin "laptop_lid_switch" ''
    #!/usr/bin/env bash

    if grep open /proc/acpi/button/lid/LID0/state; then
    		hyprctl keyword monitor "eDP-1, 2256x1504@60, 0x0, 1"
    else
    		if [[ `hyprctl monitors | grep "Monitor" | wc -l` != 1 ]]; then
    				hyprctl keyword monitor "eDP-1, disable"
    		else
    				systemctl suspend
    		fi
    fi
  '';
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.keyBinds = {
      bind = {
        "SUPER, Return" = "exec, foot";
        "SUPER_SHIFT, Return" = "exec,[floating] foot";
        "SUPER, Space" = "exec, fuzzel";
        "SUPER, W" = "killactive,";
        "SUPER_SHIFT, F" = "Fullscreen,0";
        "SUPER, F" = "togglefloating,";
        "SUPER, C" = "exec, codium";
        "SUPER, D" = "exec, firefox";
        "SUPER, S" = "exec, spotify";
        "SUPER, V" = "exec, pavucontrol";
        "SUPER, X" = "exec, VSCodium";
        "SUPER_SHIFT, Q" = "exit";

        # Screenshot
        ",Print" = "exec,grimblast --notify copysave area";
        "SHIFT, Print" = "exec,grimblast --notify copy active";
        "CONTROL,Print" = "exec,grimblast --notify copy screen";
        "SUPER,Print" = "exec,grimblast --notify copy window";
        "ALT,Print" = "exec,grimblast --notify copy area";
        "SUPER,bracketleft" = "exec,grimblast --notify --cursor copysave area ~/$(date \" + %Y-%m-%d \"T\"%H:%M:%S_no_watermark \").png";
        "SUPER,bracketright" = "exec, grimblast --notify --cursor copy area";

        # Focus
        "SUPER,h" = "movefocus,l";
        "SUPER,l" = "movefocus,r";
        "SUPER,k" = "movefocus,u";
        "SUPER,j" = "movefocus,d";
        "SUPERCONTROL,h" = "focusmonitor,l";
        "SUPERCONTROL,l" = "focusmonitor,r";
        "SUPERCONTROL,k" = "focusmonitor,u";
        "SUPERCONTROL,j" = "focusmonitor,d";

        # Change Workspace
        "SUPER,1" = "workspace,01";
        "SUPER,2" = "workspace,02";
        "SUPER,3" = "workspace,03";
        "SUPER,4" = "workspace,04";
        "SUPER,5" = "workspace,05";
        "SUPER,6" = "workspace,06";
        "SUPER,7" = "workspace,07";
        "SUPER,8" = "workspace,08";
        "SUPER,9" = "workspace,09";
        "SUPER,0" = "workspace,10";

        # Move Workspace
        "SUPERSHIFT,1" = "movetoworkspacesilent,01";
        "SUPERSHIFT,2" = "movetoworkspacesilent,02";
        "SUPERSHIFT,3" = "movetoworkspacesilent,03";
        "SUPERSHIFT,4" = "movetoworkspacesilent,04";
        "SUPERSHIFT,5" = "movetoworkspacesilent,05";
        "SUPERSHIFT,6" = "movetoworkspacesilent,06";
        "SUPERSHIFT,7" = "movetoworkspacesilent,07";
        "SUPERSHIFT,8" = "movetoworkspacesilent,08";
        "SUPERSHIFT,9" = "movetoworkspacesilent,09";
        "SUPERSHIFT,0" = "movetoworkspacesilent,10";
        "SUPERALT,h" = "movecurrentworkspacetomonitor,l";
        "SUPERALT,l" = "movecurrentworkspacetomonitor,r";
        "SUPERALT,k" = "movecurrentworkspacetomonitor,u";
        "SUPERALT,j" = "movecurrentworkspacetomonitor,d";
        "ALTCTRL,L" = "movewindow,r";
        "ALTCTRL,H" = "movewindow,l";
        "ALTCTRL,K" = "movewindow,u";
        "ALTCTRL,J" = "movewindow,d";

        # Swap windows
        "SUPERSHIFT,h" = "swapwindow,l";
        "SUPERSHIFT,l" = "swapwindow,r";
        "SUPERSHIFT,k" = "swapwindow,u";
        "SUPERSHIFT,j" = "swapwindow,d";

        # Scratch Pad
        "SUPER,u" = "togglespecialworkspace";
        "SUPERSHIFT,u" = "movetoworkspace,special";
      };
      bindi = {
        ",XF86MonBrightnessUp" = "exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
        ",XF86MonBrightnessDown" = "exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        ",XF86AudioRaiseVolume" = "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
        ",XF86AudioLowerVolume" = "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
        ",XF86AudioMute" = "exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        ",XF86AudioMicMute" = "exec, wpctl set-mute @DEFAULT_INPUT_SOURCE@ toggle";
        ",XF86AudioNext" = "exec,playerctl -p spotify next";
        ",XF86AudioPrev" = "exec,playerctl -p spotify previous";
        ",XF86AudioPlay" = "exec,playerctl -p spotify play-pause";
        ",XF86AudioStop" = "exec,playerctl -p spotify stop";
      };
      bindl = {
        ",switch:Lid Switch" = "exec, ${laptop_lid_switch}/bin/laptop_lid_switch";
      };
      binde = {
        "SUPERALT, h" = "resizeactive, -20 0";
        "SUPERALT, l" = "resizeactive, 20 0";
        "SUPERALT, k" = "resizeactive, 0 -20";
        "SUPERALT, j" = "resizeactive, 0 20";
      };
      bindm = {
        "SUPER, mouse:272" = "movewindow";
        "SUPER, mouse:273" = "resizewindow";
      };
    };
  };
}
