{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.wms.bars.polybar;
  mprisScript = pkgs.callPackage ./scripts/mpris.nix { };
  inherit (config.colorscheme) palette;
in
{
  options.modules.wms.bars.polybar = {
    enable = mkEnableOption "enable polybar bar";
  };

  config = mkIf cfg.enable {
    services.polybar = {
      enable = true;

      package = pkgs.polybarFull;

      script = "polybar main &";

      settings = {
        "settings" = {
          screenchange-reload = true;
          format-padding = 0.5;
        };

        # "colors" = {
        #   bg = "#131313";
        #   bg-alt = "#000000";
        #   fg = "#ffffff";
        #   fg-alt = "#ffffff";
        #   blue = "#81a1c1";
        #   cyan = "#8fbcbb";
        #   green = "#a3be8c";
        #   orange = "#d08770";
        #   purple = "#b48ead";
        #   red = "#bf616a";
        #   yellow = "#ebcb8b";
        # };

        "colors" = {
          bg = "#${palette.base00}";
          bg-alt = "#${palette.base00}";
          fg = "#${palette.base05}";
          fg-alt = "#${palette.base07}";
          blue = "#${palette.base0D}";
          cyan = "#${palette.base0C}";
          green = "#${palette.base0B}";
          orange = "#${palette.base09}";
          purple = "#${palette.base0F}";
          red = "#${palette.base08}";
          yellow = "#${palette.base0A}";
        };

        "bar/main" = {
          dpi = config.my.settings.dpi;
          top = true;
          center = true;
          height = lib.mkDefault 20;
          enable-ipc = true;
          foreground = "\${palette.fg}";
          background = "\${palette.bg}";
          border-bottom-color = "\${palette.bg-alt}";
          border-bottom-size = 1;
          border-top-color = "\${palette.bg-alt}";
          border-top-size = 1;
          font-0 = lib.mkDefault "${config.my.settings.fonts.regular}:size=10;2";
          module-margin-left = 1;
          module-margin-right = 1;
          modules-left = "bspwm";
          modules-center = "now-playing";
          modules-right = "battery cpu temperature memory volume date time";
          padding-left = 1;
          padding-right = 1;
          tray-position = "right";
          separator = "%{F#${palette.base02}}|%{F-}";
        };

        "module/workspaces" = {
          type = "internal/xworkspaces";
          pin-workspaces = true;
          enable-click = true;
          enable-scroll = true;
          reverse-scroll = true;
        };

        "module/now-playing" = {
          type = "custom/script";
          exec = "${mprisScript}/bin/mpris";
          tail = true;
          label-maxlen = 800;
          interval = 2;
          format = "<label>";
          format-padding = 2;
        };

        "module/battery" = {
          type = "internal/battery";
          battery = "BAT1";
          adapter = "ACAD";
          format-discharging = "<label-discharging>";
          format-charging = "<label-charging>";
          format-full = "<label-full>";
          label-charging = "%percentage%%";
          label-discharging = "%percentage%%";
          label-full = "%percentage%%";
          poll-interval = 10;
        };

        "module/bspwm" = {
          type = "internal/bspwm";
          enable-click = true;
          enable-scroll = true;
          pin-workspaces = false;
          format = "<label-state>";
          label-empty-padding = 1;
          label-focused-padding = 1;
          label-occupied-padding = 1;
          label-urgent-padding = 1;
          label-focused-foreground = "\${colors.bg}";
          label-focused-background = "\${colors.fg}";
          label-occupied-foreground = "\${colors.fg}";
          label-empty-foreground = "\${colors.fg}";
        };

        "module/temperature" = {
          type = "internal/temperature";
          interval = 3;
          # hwmon-path = "\${env:HWMON_PATH}";
          hwmon-path =
            "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon4/temp1_input";
          thermal-zone = 0;
          base-temperature = 40;
          warn-temperature = 85;
          label = "%temperature-c%";
          label-warn = "%temperature-c%";
          label-warn-foreground = "\${colors.red}";
          format = "<label>";
          format-warn = "<label-warn>";
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = 3;
          label = "%percentage:2%%";
        };

        "module/memory" = {
          type = "internal/memory";
          interval = 30;
          label = "%gb_used%";
        };

        "module/volume" = {
          type = "internal/pulseaudio";
          use-ui-max = false;
          interval = 2;
          bar-volume-empty-foreground = "\${colors.fg-alt}";
          format-volume = "<label-volume>";
          label-muted-font = 1;
          label-muted = "%{F#b77a76}MUTED";
          label-volume-font = 1;
          label-volume = "%{A3:${pkgs.pavucontrol}/bin/pavucontrol & disown:}%percentage%%%{A}";
        };

        "module/time" = {
          type = "internal/date";
          interval = 5;
          time = "%r";
          label = "%time%";
        };

        "module/date" = {
          type = "internal/date";
          interval = 3600;
          date = "%Y-%m-%d";
          label =
            "%{A1:${pkgs.gsimplecal}/bin/gsimplecal & disown:}%{A3:${pkgs.gsimplecal}/bin/gsimplecal & disown:}%date%%{A}%{A}";
        };
      };
    };

    xdg.configFile."polybar/scripts" = {
      source = ./scripts;
      recursive = true;
    };

    # Fix systemd startup issues
    systemd.user.services.polybar = {
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
