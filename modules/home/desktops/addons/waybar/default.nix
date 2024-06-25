{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.desktops.addons.waybar;
in {
  options.desktops.addons.waybar = {
    enable = mkEnableOption "Enable waybar";
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

      style = builtins.readFile ./styles-gruvbox-material.css;
    };
  };
}
