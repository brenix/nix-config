{ config, pkgs, ... }:

let
  # Dependencies
  jq = "${pkgs.gojq}/bin/gojq";
  playerctl = "${pkgs.playerctl}/bin/playerctl";

  jsonOutput = { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-output" ''
    set -euo pipefail
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
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    settings = {
      primary = {
        mode = "dock";
        height = 18;
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
          spacing = 2;
        };

        clock = {
          format = "{:%a %b %d %I:%M %p}";
          on-click = "xdg-open https://calendar.google.com";
          tooltip = false;
        };

        cpu = {
          format = "CPU:  {usage}%";
          tooltip = false;
        };

        temperature = {
          format = "TEMP: {temperatureC}°C";
          hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon4/temp1_input";
          critical-threshold = 70;
          tooltip = false;
        };

        memory = {
          format = "MEM:  {used:0.1f}G";
          interval = 5;
          tooltip = false;
        };

        pulseaudio = {
          format = "VOL: {volume}%";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          tooltip = false;
        };

        "custom/gpu" = {
          interval = 5;
          return-type = "json";
          exec = jsonOutput {
            text = "$(cat /sys/class/drm/card0/device/gpu_busy_percent)";
          };
          format = "GPU: {}%";
          tooltip = false;
        };

        "custom/separator" = {
          format = "|";
          interval = "once";
          tooltip = false;
        };

        "custom/player" = {
          exec-if = "${playerctl} status";
          exec = ''${playerctl} metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{title}} ({{artist}} - {{album}})"}' '';
          return-type = "json";
          interval = 3;
          max-length = 90;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤";
            "Stopped" = "󰓛";
          };
          on-click = "${playerctl} play-pause";
          tooltip = false;
        };
      };

    };

    style =
      let inherit (config.colorscheme) colors; in
      ''
        * {
          border: none;
          border-radius: 0;
          /* font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family}; */
          font-family: Terminus;
          font-size: 12px;
          min-height: 0;
        }

        window#waybar {
          color: #${colors.base05};
          background-color: #${colors.base00};
          border-bottom: 1px solid #${colors.base03};
        }

        tooltip {
          background: #${colors.base00};
          border: 1px solid #${colors.base03}; 
        }

        #workspaces button {
          padding: 0 5px;
          background-color: #${colors.base01};
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

        #custom-separator {
          color: #${colors.base03};
          padding: 0 5px;
        }

        #tray {
          padding: 0 5px;
        }
      '';
  };
}
