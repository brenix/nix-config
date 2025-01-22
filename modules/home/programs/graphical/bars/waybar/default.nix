{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.bars.waybar;
in {
  options.${namespace}.programs.graphical.bars.waybar = {
    enable = mkBoolOpt false "Enable waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = false;
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
            "custom/nowplaying"
          ];
          modules-right = [
            "pulseaudio"
            "cpu"
            "memory"
            "temperature"
            "backlight"
            "battery"
            "network"
            "clock"
            "tray"
          ];
          "hyprland/workspaces" = {
            # format = "{icon}";
            format = "{name}";
            sort-by-number = true;
            active-only = false;
            format-icons = {
              "1" = " 󰲌 ";
              "2" = "  ";
              "3" = " 󰎞 ";
              "4" = "  ";
              "5" = "  ";
              "6" = " 󰺵 ";
              "7" = "  ";
              urgent = "  ";
              focused = "  ";
              default = "  ";
            };
            on-click = "activate";
          };
          "custom/nowplaying" = {
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
          clock = {
            format = "󰃰 {:%Y-%m-%d %I:%M %p}";
            interval = 1;
          };
          backlight = {
            format = " {percent}%";
          };
          battery = {
            states = {
              good = 80;
              warning = 50;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-alt = "{time}";
            format-charging = "  {capacity}%";
            format-icons = ["󰁻 " "󰁽 " "󰁿 " "󰂁 " "󰂂 "];
          };
          temperature = {
            interval = 1;
            hwmon-path = ["/sys/class/hwmon/hwmon4/temp1_input" "/sys/class/hwmon/hwmon1/temp1_input"];
            tooltip = false;
            thermal-zone = 1;
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-critical = "{icon} {temperatureC}°C";
            format-icons = ["" "" "" "" ""];
          };
          cpu = {
            interval = 1;
            tooltip = false;
            format = "  {usage}%";
          };
          memory = {
            interval = 30;
            format = "  {used:0.1f}GiB";
            tooltip-format = "{used:0.1f}GiB/{total:0.1f}GiB";
          };
          network = {
            interval = 1;
            format-wifi = " {essid}";
            format-ethernet = " 󰈀  Wired";
            format-disconnected = " 󱚵  Disconnected";
            tooltip-format = "{ipaddr}/{cidr}";
          };
          pulseaudio = {
            scroll-step = 2;
            format = "{icon} {volume}%";
            format-bluetooth = " {icon} {volume}%";
            format-muted = "  ";
            format-icons = {
              headphone = "  ";
              headset = "  ";
              default = ["  " "  "];
            };
          };
          tray = {
            icon-size = 16;
            spacing = 8;
          };
        }
      ];

      style = with config.lib.stylix.colors.withHashtag; ''

        @define-color black ${base00};
        @define-color white ${base05};
        @define-color blue ${base0D};
        @define-color green ${base0B};
        @define-color red ${base08};
        @define-color orange ${base09};
        @define-color yellow ${base0A};
        @define-color cyan ${base0C};
        @define-color magenta ${base0E};

        /*
        @define-color black #161617;
        @define-color white #c9c7cd;
        @define-color blue #9cb2cf;
        @define-color green #90b99f;
        @define-color red #ea83a5;
        @define-color orange #e6b99d;
        @define-color yellow #e6dc9d;
        @define-color cyan #85b5ba;
        @define-color magenta #ae9ee2;
        */

        * {
          border: 0;
          border-radius: 0;
          padding: 0 0;
          font-family: "Terminus";
          font-size: 9pt;
          color: white;
        }

        window#waybar {
          border: 0px solid rgba(0, 0, 0, 0);
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

        #workspaces button.active * {
          color: @black;
          background-color: @blue;
        }

        #workspaces button.visible {
          color: white;
          background-color: @black;
        }

        /*
        #workspaces button.visible * {
          color: @black;
        }
        */

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

        #clock {
          color: @yellow;
        }

        #backlight {
          color: @white;
        }

        #battery {
          color: @white;
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

        #pulseaudio {
          color: @cyan;
        }

        #pulseaudio.muted {
          color: #3b4252;
        }

        #temperature {
          color: @orange;
        }

        #temperature.critical {
          color: @red;
        }

        #cpu {
          color: @blue;
        }

        #cpu #cpu-icon {
          color: @blue;
        }

        #memory {
          color: @green;
        }

        #network {
          color: @red;
        }

        #custom-player{
          color: @white;
        }

        #custom-currentplayer{
          color: @white;
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
