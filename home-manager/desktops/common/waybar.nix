{ config, pkgs, lib, ... }:
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
          height = 16;
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
            "network"
            "clock"
            "tray"
          ];
          "hyprland/workspaces" = {
            format = "{icon}";
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
              "spotify" = " 󰓇";
              "firefox" = " ";
              "discord" = " 󰙯";
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
              "Paused" = "󰏤 ";
              "Stopped" = "󰓛";
            };
            on-click = "playerctl play-pause";
          };
          battery = {
            states = {
              good = 80;
              warning = 50;
              critical = 15;
            };
            format = "{icon}  {capacity}%";
            format-alt = "{time}";
            format-full = "";
            format-charging = "  {capacity}%";
            format-plugged = "  {capacity}%";
            format-icons = [ " " " " " " " " " " ];
          };
          temperature = {
            interval = 1;
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
            format = "󰍛 {used:0.1f}GiB";
            tooltip-format = "{used = 0.1f}GiB/{avail = 0.1f}GiB";
          };
          network = {
            interval = 1;
            format-wifi = "  {essid} {signalStrength}%";
            tooltip-format-wifi = "IP = {ipaddr}\nSSID = {essid}";
            format-ethernet = "󰈀";
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
            format = "  {:%a %d %b  %I:%M %p}";
            format-alt = "  {:%d/%m/%Y  %H:%M:%S}";
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
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
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
            icon-size = 14;
            spacing = 8;
          };
        }
      ];

      style =
        # css
        ''
          @define-color base      #${colorscheme.palette.base00};
          @define-color blue      #${colorscheme.palette.base0D};
          @define-color rosewater #${colorscheme.palette.base06};
          @define-color lavender  #${colorscheme.palette.base07};
          @define-color teal      #${colorscheme.palette.base0C};
          @define-color yellow    #${colorscheme.palette.base0A};
          @define-color green     #${colorscheme.palette.base0B};
          @define-color red       #${colorscheme.palette.base08};
          @define-color mauve     #${colorscheme.palette.base0E};
          @define-color flamingo  #${colorscheme.palette.base0F};

          * { 
           color: @lavender;
           border: 0;
           padding: 0 0;
           font-family: Terminus, ${config.my.settings.fonts.monospace};
           font-size: 14px;
          }

          window#waybar {
           border: 0px solid rgba(0, 0, 0, 0);
           background-color: rgba(0, 0, 0, 0);
          }

          #workspaces * {
           color: white;
          }

          #workspaces {
           border-style: solid;
           background-color: @base;
           opacity: 1;
           margin: 8px 8px 8px 8px;
          }

          #workspaces button {
           color: @base;
           padding: 2px;
           margin: 2px 4px 0px 4px;
          }

          #workspaces button:hover {
           color: @mauve;
          }


          #workspaces button.active * {
           color: @base;
           background-color: @mauve;
          }

          #workspaces button.visible {
           color: white;
           background-color: @mauve;
          }

          #workspaces button.visible * {
           color: white;
           color: @base;
          }

          #mode {
           color: @yellow;
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
          #tray,
          #mpd {
           padding: 5px 8px;
           border-style: solid;
           background-color: shade(@base, 1);
           opacity: 1;
           margin: 8px 0;
          }

          /* -----------------------------------------------------------------------------
          * Module styles
          * -------------------------------------------------------------------------- */
          #mpd {
           color: @mauve;
           margin-left: 5px;
           background-color: rgba(0, 0, 0, 0);
          }

          #mpd.2 {
           margin: 8px 0px 8px 6px;
           padding: 4px 12px 4px 10px;
          }

          #mpd.3 {
           margin: 8px 0px 8px 0px;
           padding: 4px;
          }

          #mpd.4 {
           margin: 8px 0px 8px 0px;
           padding: 4px 10px 4px 14px;
          }

          #mpd.2,
          #mpd.3,
          #mpd.4 {
           background-color: @base;
           font-size: 14px;
          }

          #clock {
           color: @mauve;
           margin: 8px 10px;
          }


          #backlight {
           color: @yellow;
           margin-left: 10px;
          }

          #battery {
           color: @yellow;
           margin-right: 10px;
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

          #custom-notification {
          	margin-left: 10px;
          	color: @lavender;
          	background: @base;
          }

          #tray {
          	 margin: 8px 10px;
          }

          #idle_inhibitor.deactivated {
          	background-color: shade(@base, 1);
          	color: @lavender;
          }

          #idle_inhibitor.activated {
          	 background-color: shade(@base, 1);
          	 color: @green;
          }

          #idle_inhibitor {
          	 background-color: @yellow;
          	 color: @base;
          }



          #pulseaudio {
          	 color: @flamingo;
          	 margin-right: 10px;
          }

          #pulseaudio.muted {
          	 color: #3b4252;
          }

          #temperature {
          	 color: @teal;
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
          	 color: @flamingo;
          	 margin-right: 5px;
          }

          #network {
          	 color: @lavender;
          	 margin-right: 5px;
          }

          #network.disconnected {
          	 color: @red;
          }

          #custom-launcher {
          	 background-color: @mauve;
          	 color: @base;
          	 padding: 5px 10px;
          	 margin-left: 15px;
          	 font-size: 24px;
          }

          #custom-power {
          	 margin: 8px;
          	 padding: 5px;
          	 transition: none;
          	 color: @red;
          	 background: @base;
          }

          #window {
          	 border-style: hidden;
          	 margin-left: 10px;
          }

          #mode {
          	 margin-bottom: 3px;
          }
        '';
    };
  };
}
