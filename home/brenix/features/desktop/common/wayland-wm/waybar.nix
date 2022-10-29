{ config, lib, pkgs, ... }:

let
  inherit (pkgs.lib) optionals optional;

  # Dependencies
  jq = "${pkgs.gojq}/bin/gojq";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";

  jsonOutput = { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-output" ''
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-output";
in
{
  programs.waybar = {
    enable = true;
    settings = {
      primary = {
        mode = "dock";
        layer = "top";
        height = 20;
        /* margin = "6"; */
        position = "top";
        output = builtins.map (m: m.name) (builtins.filter (m: m.isSecondary == false) config.monitors);

        modules-left = [
          "wlr/workspaces"
        ];

        modules-center = [
          "custom/player"
        ];

        modules-right = [
          "cpu"
          "custom/separator"
          "temperature"
          "custom/separator"
          "custom/gpu"
          "custom/separator"
          "memory"
          "custom/separator"
          "pulseaudio"
          "custom/separator"
          "clock"
          "tray"
        ];

        "wlr/workspaces" = {
          on-click = "activate";
        };

        tray = {
          spacing = 5;
        };

        clock = {
          format = "{:%a %b %d %I:%M %p}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = {
          format = "CPU:  {usage}%";
        };

        temperature = {
          format = "TEMP: {temperatureC}°C";
          hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon3/temp1_input";
          critical-threshold = 70;
        };

        memory = {
          format = "MEM:  {used:0.1f}G";
          interval = 5;
        };

        pulseaudio = {
          format = "VOL: {volume}%";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };

        "custom/gpu" = {
          interval = 5;
          return-type = "json";
          exec = jsonOutput {
            text = "$(cat /sys/class/drm/card0/device/gpu_busy_percent)";
            tooltip = "GPU Usage";
          };
          format = "GPU: {}%";
        };

        "custom/separator" = {
          "format" = "|";
          "interval" = "once";
          "tooltip" = false;
        };

        "custom/player" = {
          exec-if = "${playerctl} status";
          exec = ''${playerctl} metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{title}} ({{artist}} - {{album}})"}' '';
          return-type = "json";
          interval = 3;
          max-length = 90;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "契";
            "Paused" = " ";
            "Stopped" = "栗";
          };
          on-click = "${playerctl} play-pause";
        };
      };

    };

    style =
      let inherit (config.colorscheme) colors; in
      ''
        * {
          font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
          font-size: 16px;
          padding: 0 6px;
        }
        .modules-right {
          margin-right: -15px;
        }
        .modules-left {
          margin-left: -15px;
        }
        window#waybar.top {
          color: #${colors.base05};
          opacity: 1.0;
          background-color: #${colors.base00};
          border: 2px solid #${colors.base03};
          padding: 0;
        }
        window#waybar.bottom {
          color: #${colors.base05};
          background-color: #${colors.base00};
          border: 2px solid #${colors.base03};
          opacity: 1.0;
        }
        #workspaces button {
          border-radius: 4px;
          background-color: #${colors.base01};
          border-top: 2px solid #${colors.base03};
          border-bottom: 2px solid #${colors.base03};
          color: #${colors.base05};
        }
        #workspaces button.hidden {
          background-color: #${colors.base00};
          color: #${colors.base05};
        }
        #workspaces button.focused,
        #workspaces button.active {
          background-color: #${colors.base0D};
          color: #${colors.base00};
        }
        #clock {
          margin-right: 0.5px;
        }
        #custom-separator {
          color: #${colors.base04};
          margin-left: 0.5px;
        }
      '';
  };
}
