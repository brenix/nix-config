{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (config.stylix) polarity;

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
          height = 12;
          margin = "0 0 0 0";
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "custom/mpd"
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
          "custom/spotify" = {
            exec-if = "playerctl -p spotify status";
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
          "custom/mpd" = {
            exec-if = ''mpc status "%state%"'';
            exec = ''mpc current --format '{"text": "%title%", "tooltip": "%name%"}' '';
            return-type = "json";
            interval = 1;
            max-length = 100;
            format = "{icon} {}";
            format-icons = {
              "Playing" = "";
              "Paused" = "";
              "Stopped" = "";
            };
            on-click = "mpc toggle";
            escape = true;
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

      style = with config.lib.stylix.colors.withHashtag; let
        background =
          if polarity == "light"
          then "#181818"
          else base00;
        foreground =
          if polarity == "light"
          then base00
          else base05;
      in ''
        @define-color black ${background};
        @define-color white ${foreground};
        @define-color grey ${base01};
        @define-color blue ${base0D};
        @define-color green ${base0B};
        @define-color red ${base08};
        @define-color orange ${base09};
        @define-color yellow ${base0A};
        @define-color cyan ${base0C};
        @define-color magenta ${base0E};

        * {
          border: 0;
          border-radius: 0;
          padding: 0 0;
          font-family: "Terminus";
          font-size: 9pt;
          min-height: 0;
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
          background-color: @white;
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
          color: @white;
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
          color: @white;
        }

        @keyframes blink {
          to {
            color: @red;
          }
        }

        #pulseaudio {
          color: @white;
        }

        #pulseaudio.muted {
          color: @grey;
        }

        #temperature {
          color: @white;
        }

        #temperature.critical {
          color: @red;
        }

        #cpu {
          color: @white;
        }

        #cpu #cpu-icon {
          color: @white;
        }

        #memory {
          color: @white;
        }

        #network {
          color: @white;
        }

        #spotify{
          color: @white;
        }

        #mpd{
          color: @white;
        }

        #network.disconnected {
          color: @white;
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
