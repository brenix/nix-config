{ config, lib, pkgs, hostname, ... }:

let
  inherit (builtins) attrValues concatStringsSep mapAttrs;
  inherit (pkgs.lib) optionals optional;
  inherit (config.home.preferredApps) menu terminal;

  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
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
        height = 21;
        margin = "6";
        position = "top";

        output =
          (optional (hostname == "neo") "DP-1") ++
          (optional (hostname == "tank") "Virtual-1");

        modules-left = [
          "workspaces"
        ];

        modules-center = [
          "custom/currentplayer"
          "custom/player"
        ];

        modules-right = [
          "cpu"
          "custom/gpu"
          "memory"
          "pulseaudio"
          "custom/weather"
          "clock"
          "tray"
        ];

        workspaces = {
          on-click = "activate";
        };

        clock = {
          format = " {:%a %b %d %I:%M%p}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = {
          format = "  {usage}%";
        };

        temperature = {
          format = " {temperatureC}°C";
          tooltip = "CPU Temperature";
        };

        memory = {
          format = "  {}%";
          interval = 5;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "";
            headset = "";
            portable = "";
            default = [ "" "" "" ];
          };
        };

        "custom/weather" = {
          tooltip = false;
          min-length = 5;
          exec = "curl -s 'https://wttr.in/Sacramento?u&format='%f'' | tr -d '+'";
          interval = 3600;
          format = "  {}";
        };

        "custom/gpu" = {
          interval = 5;
          return-type = "json";
          exec = jsonOutput {
            text = "$(cat /sys/class/drm/card0/device/gpu_busy_percent)";
            tooltip = "GPU Usage";
          };
          format = "力  {}%";
        };

        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = jsonOutput {
            pre = ''player="$(${playerctl} status -f "{{playerName}}" || echo "No players found" | cut -d '.' -f1)"'';
            alt = "$player";
            tooltip = "$player";
          };
          format = "{icon}";
          format-icons = {
            "No players found" = "ﱘ";
            "spotify" = "阮";
            "firefox" = "爵";
            "discord" = "ﭮ";
          };
          on-click = "${systemctl} --user restart playerctld";
        };

        "custom/player" = {
          exec-if = "${playerctl} status";
          exec = ''${playerctl} metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{title}} ({{artist}} - {{album}})"}' '';
          return-type = "json";
          interval = 3;
          max-length = 30;
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

    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style =
      let inherit (config.colorscheme) colors; in
      ''
        * {
          font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
          font-size: 12px;
          padding: 0 8px;
        }
        .modules-right {
          margin-right: -15;
        }
        .modules-left {
          margin-left: -15;
        }
        window#waybar.top {
          color: #${colors.base05};
          opacity: 1.0;
          background-color: #${colors.base00};
          border: 2px solid #${colors.base03};
          padding: 0;
          border-radius: 10px;
        }
        window#waybar.bottom {
          color: #${colors.base05};
          background-color: #${colors.base00};
          border: 2px solid #${colors.base03};
          opacity: 1.0;
          border-radius: 10px;
        }
        #workspaces button {
          background-color: #${colors.base01};
          color: #${colors.base05};
          margin: 4px;
        }
        #workspaces button.hidden {
          background-color: #${colors.base00};
          color: #${colors.base04};
        }
        #workspaces button.focused,
        #workspaces button.active {
          background-color: #${colors.base0A};
          color: #${colors.base00};
        }
      '';
  };
}
