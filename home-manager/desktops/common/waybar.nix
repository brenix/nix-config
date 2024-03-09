{ config, lib, ... }:
with lib;
let
  cfg = config.modules.wms.bars.waybar;
  inherit (config) colorscheme;
in
{
  options.modules.wms.bars.waybar = {
    enable = mkEnableOption "enable waybar bar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
      };
      settings = [
        {
          layer = "top";
          position = "top";
          height = 13;
          margin = "0 0 0 0";
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "custom/currentplayer"
            "custom/player"
          ];
          modules-right = [
            "pulseaudio"
            "temperature"
            "cpu"
            "memory"
            "backlight"
            "battery"
            # "network"
            "clock"
            "tray"
          ];
          "hyprland/workspaces" = {
            # format = "{icon}";
            format = "{name}";
            sort-by-number = true;
            active-only = false;
            format-icons = {
              "1" = "  ";
              "2" = "  ";
              "3" = "  ";
              "4" = "  ";
              urgent = "  ";
              focused = "  ";
              default = "  ";
            };
            on-click = "activate";
          };
          "custom/currentplayer" = {
            interval = 2;
            return-type = "json";
            format = "{icon}{}";
            format-icons = {
              "No player active" = " ";
              "spotify" = " ";
              "firefox" = " ";
            };
            on-click = "playerctld shift";
            on-click-right = "playerctld unshift";
          };
          "custom/player" = {
            exec-if = "playerctl status";
            exec = ''playerctl metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{title}} ({{artist}} - {{album}})"}' '';
            return-type = "json";
            interval = 1;
            max-length = 30;
            format = "{icon} {}";
            format-icons = {
              "Playing" = "";
              "Paused" = "";
              "Stopped" = "";
            };
            on-click = "playerctl play-pause";
          };
          battery = {
            states = {
              good = 80;
              warning = 50;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-alt = "{time}";
            format-full = "";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-icons = [ "" "" "" "" "" ];
          };
          temperature = {
            interval = 1;
            hwmon-path = [ "/sys/class/hwmon/hwmon4/temp1_input" "/sys/class/hwmon/hwmon1/temp1_input" ];
            tooltip = false;
            thermal-zone = 1;
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-critical = "{icon} {temperatureC}°C";
            format-icons = [ "" "" "" "" "" ];
          };
          cpu = {
            interval = 1;
            tooltip = false;
            format = " {usage}%";
          };
          memory = {
            interval = 30;
            format = " {used:0.1f}GiB";
            tooltip-format = "{used:0.1f}GiB/{total:0.1f}GiB";
          };
          network = {
            interval = 1;
            format-wifi = " {essid}";
            # format-wifi = " {essid} {signalStrength}%";
            tooltip-format-wifi = "IP = {ipaddr}\nSSID = {essid}";
            format-ethernet = "󰈀 Ethernet";
            tooltip-format-ethernet = "IP = {ipaddr}";
            format-disconnected = "Disconnected ⚠";
            tooltip-format = ''
              {ifname}
              {ipaddr}/{cidr}
              Up: {bandwidthUpBits}
              Down: {bandwidthDownBits}'';
          };
          backlight = {
            tooltip = false;
            format = " {percent}%";
          };
          pulseaudio = {
            scroll-step = 2;
            format = "{icon} {volume}%";
            format-bluetooth = " {icon} {volume}%";
            format-muted = "";
            format-icons = {
              headphone = "";
              headset = "";
              default = [ "" "" ];
            };
          };
          clock = {
            format = " {:%Y-%m-%d %I:%M %p}";
            format-alt = " {:%d/%m/%Y %H:%M:%S}";
            interval = 1;
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              "mode-mon-col" = 3;
              "weeks-pos" = "right";
              "on-scroll" = 1;
              "on-click-right" = "mode";
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#999999'><b>{}</b></span>";
                weeks = "<span color='#cccccc'><b>W{}</b></span>";
                weekdays = "<span color='#aaaaaa'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              "on-click-right" = "mode";
              "on-click-forward" = "tz_up";
              "on-click-backward" = "tz_down";
              "on-scroll-up" = "shift_up";
              "on-scroll-down" = "shift_down";
            };
          };
          tray = {
            icon-size = 12;
            spacing = 2;
          };
        }
      ];

      style =
        # css
        ''
          @define-color black       #${colorscheme.palette.base00};
          @define-color darkergrey  #${colorscheme.palette.base01};
          @define-color darkgrey    #${colorscheme.palette.base02};
          @define-color grey        #${colorscheme.palette.base03};
          @define-color lightgrey   #${colorscheme.palette.base04};
          @define-color brightgrey  #${colorscheme.palette.base05};
          @define-color mostlywhite #${colorscheme.palette.base06};
          @define-color white       #${colorscheme.palette.base07};
          @define-color red         #${colorscheme.palette.base08};
          @define-color orange      #${colorscheme.palette.base09};
          @define-color yellow      #${colorscheme.palette.base0A};
          @define-color green       #${colorscheme.palette.base0B};
          @define-color cyan        #${colorscheme.palette.base0C};
          @define-color blue        #${colorscheme.palette.base0D};
          @define-color magenta     #${colorscheme.palette.base0E};
          @define-color brown       #${colorscheme.palette.base0F};

          * { 
            color: @white;
            border: 0;
            padding: 0 0;
            font-family: Terminus, ${config.my.settings.fonts.monospace};
            font-size: 14px;
          }

          window#waybar {
            border: 0px solid rgba(0, 0, 0, 0);
            /* background-color: rgba(0, 0, 0, 0); */
            background-color: @black;
          }

          #workspaces * {
            color: white;
          }

          #workspaces {
            border-style: solid;
            margin: 0 4px;
            background-color: @black;
          }

          #workspaces button {
            color: @black;
          }

          #workspaces button:hover {
            color: @black;
            background-color: @blue;
          }

          #workspaces button.active * {
            color: @white;
            background-color: @blue;
          }

          #workspaces button.visible {
            color: white;
            background-color: @blue;
          }

          #workspaces button.visible * {
            color: @black;
          }

          #clock,
          #battery,
          #cpu,
          #memory,
          #temperature,
          #backlight,
          #network,
          #pulseaudio,
          #mode,
          #tray {
            padding: 1px 8px;
            border-style: solid;
            background-color: @black;
            opacity: 1;
          }

          /* -----------------------------------------------------------------------------
          * Module styles
          * -------------------------------------------------------------------------- */
          #clock {
            color: @brightgrey;
          }

          #backlight {
            color: @brightgrey;
          }

          #battery {
            color: @brightgrey;
          }

          #battery.critical:not(.charging) {
            color: @red;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }

          #battery.charging {
            color: @green;
          }

          @keyframes blink {
           to {
             color: @red;
           }
          }

          /*
          #tray {
            margin: 8px 10px;
          }
          */

          #pulseaudio {
            color: @brightgrey;
          }

          #pulseaudio.muted {
            color: #3b4252;
          }

          #temperature {
            color: @brightgrey;
          }

          #temperature.critical {
            color: @red;
          }

          #cpu {
            color: @brightgrey;
          }

          #cpu #cpu-icon {
            color: @brightgrey;
          }

          #memory {
            color: @brightgrey;
          }

          #network {
            color: @brightgrey;
          }

          #custom-player{
            color: @brightgrey;
          }

          #custom-currentplayer{
            color: @brightgrey;
          }

          #network.disconnected {
            color: @red;
          }

          #custom-power {
            /* margin: 8px; */
            padding: 1px;
            transition: none;
            color: @red;
            background: @black;
          }

          #window {
            border-style: hidden;
          }
        '';
    };
  };
}
