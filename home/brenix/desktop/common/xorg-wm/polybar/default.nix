{ config, pkgs, ... }:

let
  mprisScript = pkgs.callPackage ./scripts/mpris.nix { };
  inherit (config.colorscheme) colors;
in
{
  services.polybar = {
    enable = true;

    package = pkgs.polybarFull;

    script = "polybar main &";

    settings = {
      "settings" = {
        screenchange-reload = true;
        format-padding = 0.5;
      };

      "colors" = {
        bg = "#${colors.base00}";
        bg-alt = "#${colors.base00}";
        fg = "#${colors.base06}";
        fg-alt = "#${colors.base05}";
        blue = "#${colors.base0D}";
        cyan = "#${colors.base0C}";
        green = "#${colors.base0B}";
        orange = "#${colors.base09}";
        purple = "#${colors.base0F}";
        red = "#${colors.base08}";
        yellow = "#${colors.base0A}";
      };

      "bar/main" = {
        top = true;
        center = true;
        height = 18;
        enable-ipc = true;
        width = "99%";
        foreground = "\${colors.fg}";
        background = "\${colors.bg}";
        border-bottom-color = "\${colors.bg}";
        border-bottom-size = 1;
        border-top-color = "\${colors.bg}";
        border-top-size = 1;
        font-0 = "${config.fontProfiles.regular.family}:size=9;2";
        font-1 = ''"Material Icons:size=9;3"'';
        font-2 = ''"JetBrainsMono Nerd Font Mono:size=12;3"'';
        module-margin-left = 1;
        module-margin-right = 1;
        modules-left = "bspwm";
        modules-center = "now-playing";
        modules-right = "battery cpu temperature memory volume date time";
        offset-x = 12;
        offset-y = 5;
        padding-left = 1;
        padding-right = 1;
        tray-position = "right";
      };

      "module/now-playing" = {
        type = "custom/script";
        exec = "${mprisScript}/bin/mpris";
        tail = true;
        label-maxlen = 800;
        interval = 2;
        format = "  <label>";
        format-padding = 2;
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT1";
        adapter = "ACAD";
        format-discharging = " <label-discharging>";
        format-charging = " <label-charging>";
        format-full = " <label-full>";
        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "%percentage%%";
        poll-interval = 10;
      };

      "module/workspaces" = {
        type = "internal/xworkspaces";
        enable-click = true;
        enable-scroll = true;
        pin-workspaces = false;
        format = "<label-state>";
        format-padding = 0;
        label-empty = "%icon%";
        label-empty-padding = 1;
        label-active = "%icon%";
        label-active-foreground = "\${colors.blue}";
        label-active-padding = 1;
        label-occupied = "%icon%";
        label-occupied-padding = 1;
        label-urgent = "%icon%";
        label-urgent-padding = 1;
        icon-0 = "1;";
        icon-1 = "2;";
        icon-2 = "3;";
        icon-3 = "4;";
        icon-default = "";
      };

      "module/bspwm" = {
        type = "internal/bspwm";
        enable-click = true;
        enable-scroll = true;
        pin-workspaces = false;
        format = "<label-state>";
        format-padding = 0;
        label-empty = "%icon%";
        label-empty-padding = 1;
        label-focused = "%icon%";
        label-focused-foreground = "\${colors.blue}";
        label-focused-padding = 1;
        label-occupied = "%icon%";
        label-occupied-padding = 1;
        label-urgent = "%icon%";
        label-urgent-padding = 1;
        ws-icon-0 = "1;";
        ws-icon-1 = "2;";
        ws-icon-2 = "3;";
        ws-icon-3 = "4;";
        ws-icon-default = "";
      };

      "module/temperature" = {
        type = "internal/temperature";
        interval = 3;
        # hwmon-path = "\${env:HWMON_PATH}";
        hwmon-path =
          "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon3/temp1_input";
        thermal-zone = 0;
        base-temperature = 20;
        warn-temperature = 60;
        label = "%temperature-c%";
        label-warn = "%temperature-c%";
        label-warn-foreground = "\${colors.red}";
        format = "<label>";
        format-prefix = " ";
        format-warn = "<label-warn>";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 3;
        label = "%percentage:2%%";
        format-prefix = " ";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 30;
        label = "%gb_used%";
        format-prefix = " ";
      };

      "module/volume" = {
        type = "internal/pulseaudio";
        use-ui-max = false;
        interval = 2;
        bar-volume-empty-foreground = "\${colors.fg-alt}";
        format-volume = "<ramp-volume> <label-volume>";
        label-muted = " %{F#b77a76}MUTED";
        label-muted-foreground = "\${colors.fg-alt}";
        label-volume =
          "%{A3:${pkgs.pavucontrol}/bin/pavucontrol & disown:}%percentage%%%{A}";
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
      };

      "module/time" = {
        type = "internal/date";
        interval = 5;
        time = "%r";
        label = "%time%";
        format-prefix = " ";
      };

      "module/date" = {
        type = "internal/date";
        interval = 3600;
        date = "%Y-%m-%d";
        label =
          "%{A1:${pkgs.gsimplecal}/bin/gsimplecal & disown:}%{A3:${pkgs.gsimplecal}/bin/gsimplecal & disown:} %date%%{A}%{A}";
      };
    };
  };

  xdg.configFile."polybar/scripts" = {
    source = ./scripts;
    recursive = true;
  };
}
