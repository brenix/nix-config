{pkgs, ...}: {
  programs.labwc.config.keyboard = {
    repeatRate = 45;
    repeatDelay = 280;
    keybinds = [
      {
        key = "A-Tab";
        actions = [
          {
            name = "NextWindow";
          }
        ];
      }
      {
        key = "W-Return";
        actions = [
          {
            name = "Execute";
            command = "alacritty";
          }
        ];
      }
      {
        key = "W-Space";
        actions = [
          {
            name = "Execute";
            command = "fuzzel";
          }
        ];
      }
      {
        key = "W-d";
        actions = [
          {
            name = "Execute";
            command = "firefox";
          }
        ];
      }
      {
        key = "W-s";
        actions = [
          {
            name = "Execute";
            command = "spotify";
          }
        ];
      }
      {
        key = "W-v";
        actions = [
          {
            name = "Execute";
            command = "pavucontrol";
          }
        ];
      }
      {
        key = "W-w";
        actions = [
          {
            name = "Close";
          }
        ];
      }
      {
        key = "W-z";
        actions = [
          {
            name = "ToggleShade";
          }
        ];
      }
      {
        key = "W-f";
        actions = [
          {
            name = "ToggleMaximize";
          }
        ];
      }
      {
        key = "W-1";
        actions = [
          {
            name = "GoToDesktop";
            to = "1";
          }
        ];
      }
      {
        key = "W-2";
        actions = [
          {
            name = "GoToDesktop";
            to = "2";
          }
        ];
      }
      {
        key = "W-3";
        actions = [
          {
            name = "GoToDesktop";
            to = "3";
          }
        ];
      }
      {
        key = "W-4";
        actions = [
          {
            name = "GoToDesktop";
            to = "4";
          }
        ];
      }
      {
        key = "W-S-1";
        actions = [
          {
            name = "SendToDesktop";
            to = "1";
            follow = "false";
          }
        ];
      }
      {
        key = "W-S-2";
        actions = [
          {
            name = "SendToDesktop";
            to = "2";
            follow = "false";
          }
        ];
      }
      {
        key = "W-S-3";
        actions = [
          {
            name = "SendToDesktop";
            to = "3";
            follow = "false";
          }
        ];
      }
      {
        key = "W-S-4";
        actions = [
          {
            name = "SendToDesktop";
            to = "4";
            follow = "false";
          }
        ];
      }
      {
        key = "XF86MonBrightnessUp";
        actions = [
          {
            name = "Execute";
            command = "${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
          }
        ];
      }
      {
        key = "XF86MonBrightnessDown";
        actions = [
          {
            name = "Execute";
            command = "${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
          }
        ];
      }
      {
        key = "XF86AudioRaiseVolume";
        actions = [
          {
            name = "Execute";
            command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
          }
        ];
      }
      {
        key = "XF86AudioLowerVolume";
        actions = [
          {
            name = "Execute";
            command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
          }
        ];
      }
      {
        key = "XF86AudioMute";
        actions = [
          {
            name = "Execute";
            command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          }
        ];
      }
      {
        key = "XF86AudioMicMute";
        actions = [
          {
            name = "Execute";
            command = "wpctl set-mute @DEFAULT_INPUT_SOURCE@ toggle";
          }
        ];
      }
      {
        key = "XF86AudioNext";
        actions = [
          {
            name = "Execute";
            command = "playerctl -p spotify next";
          }
        ];
      }
      {
        key = "XF86AudioPrev";
        actions = [
          {
            name = "Execute";
            command = "playerctl -p spotify previous";
          }
        ];
      }
      {
        key = "XF86AudioPlay";
        actions = [
          {
            name = "Execute";
            command = "playerctl -p spotify play-pause";
          }
        ];
      }
      {
        key = "XF86AudioStop";
        actions = [
          {
            name = "Execute";
            command = "playerctl -p spotify stop";
          }
        ];
      }
      {
        key = "Print";
        actions = [
          {
            name = "Execute";
            command = "grimblast --notify copysave area";
          }
        ];
      }
      {
        key = "S-Print";
        actions = [
          {
            name = "Execute";
            command = "grimblast --notify copy active";
          }
        ];
      }
      {
        key = "C-Print";
        actions = [
          {
            name = "Execute";
            command = "grimblast --notify copy screen";
          }
        ];
      }
      {
        key = "W-Print";
        actions = [
          {
            name = "Execute";
            command = "grimblast --notify copy window";
          }
        ];
      }
      {
        key = "A-Print";
        actions = [
          {
            name = "Execute";
            command = "grimblast --notify copy area";
          }
        ];
      }
    ];
  };
}
