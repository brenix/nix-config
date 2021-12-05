{ config, pkgs, ...}:{

  services.polybar = {
    enable = true;

    script = "polybar main &";

    settings = {

      "colors" = {
        bg = "#161821";
        bg-alt = "#161821";
        fg = "#ECEFF4";
        fg-alt = "#E5E9F0";

        blue = "#81A1C1";
        cyan = "#88C0D0";
        green = "#A3BE8C";
        orange = "#D08770";
        purple = "#B48EAD";
        red = "#BF616A";
        yellow = "#EBCB8B";

        trans = "#00000000";
        semi-trans-black = "#aa000000";

        shade-1 = "#5D5E72";
        shade-2 = "#7A7B8C";
        shade-3 = "#A0A0AB";
        shade-4 = "#CACACE";
        shade-5 = "#F8F8F8";
      };

      "bar/main" = {
        top = true;
        height = 20;
        enable-ipc = true;
        width = "100%";
        spacing = 0;
        foreground = "\${colors.fg}";
        background = "\${colors.bg}";
        border-bottom-color = "\${colors.bg}";
        border-bottom-size = 1;
        border-top-color = "\${colors.bg}";
        border-top-size = 1;
        font-0 = "Verdana:size=9;2";
        font-1 = "Material Icons:size=9;3";
        module-margin-left = 1;
        module-margin-right = 1;
        modules-left = "workspaces";
        /* modules-center = previous playpause next spotify; */
        modules-right = "cpu temperature memory volume date time";
        offset-x = 0;
        offset-y = 0;
        padding-left = 1;
        padding-right = 1;
      };

      "module/workspaces" = {
        type = "internal/xworkspaces";
        pin-workspaces = false;
        enable-click = true;
        enable-scroll = true;
        label-active-foreground = "\${colors.shade-1}";
        label-active-background = "\${colors.blue}";
        format-padding = 0;
        format = "<label-state>";
      };

      "module/mpd" = {
        type = "internal/mpd";
        host = "127.0.0.1";
        port = 6600;
        interval = 5;
        format-online = "<icon-prev> <toggle> <icon-next> <icon-stop> <label-song>";
        label-song = "%artist% - %title%";
        format-stopped = "";
        click-left = "mpc -q toggle";
        icon-play = "";
        icon-pause = "";
        icon-stop = "";
        icon-prev = "";
        icon-next = "";
      };

      "module/previous" = {
        type = "custom/ipc";
        hook-0 = "echo ''";
        hook-1 = "echo ''";
        click-left = "spotifyctl -q previous";
      };

      "module/next" = {
        type = "custom/ipc";
        hook-0 = "echo ''";
        hook-1 = "echo ''";
        click-left = "spotifyctl -q next";
      };

      "module/playpause" = {
        type = "custom/ipc";
        hook-0 = "echo ''";
        hook-1 = "echo ''";
        hook-2 = "echo ''";
        click-left = "spotifyctl -q playpause";
      };

      "module/spotify" = {
        type = "custom/ipc";
        hook-0 = "echo ''";
        hook-1 = "spotifyctl -q status --format '%artist%: %title%'";
      };

      "module/temperature" = {
        type = "internal/temperature";
        interval = 3;
        /* hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon3/temp1_input"; */
        thermal-zone = 0;
        base-temperature = 20;
        warn-temperature = 60;
        label = "%temperature-c%";
        label-warn = "%temperature-c%";
        label-warn-foreground = "\${colors.red}";
        format = "<label>";
        format-prefix = " ";
        format-prefix-font = 2;
        format-prefix-foreground = "\${colors.fg}";
        format-warn = "<label-warn>";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 3;
        label = "%percentage:2%%";
        format-prefix = " ";
        format-prefix-foreground = "\${colors.fg}";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 30;
        label = "%gb_used%";
        format-prefix = " ";
        format-prefix-foreground = "\${colors.fg}";
      };

      "module/volume" = {
        type = "internal/pulseaudio";
        /* sink = "alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo"; */
        use-ui-max = false;
        interval = 2;
        format-volume = "<ramp-volume> <label-volume>";
        label-volume = "%{A3:pavucontrol & disown:}%percentage%%%{A}";
        label-volume-foreground = "\${root.foreground}";
        label-muted = " %{F#b77a76}MUTED";
        label-muted-foreground = "\${colors.fg-alt}";
        bar-volume-empty-foreground = "\${colors.fg-alt}";
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
        format-prefix-foreground = "\${colors.fg}";
      };

      "module/date" = {
        type = "internal/date";
        interval = 3600;
        date = "%Y-%m-%d";
        label = "%{A1:${pkgs.gsimplecal} & disown:}%{A3:${pkgs.gsimplecal} & disown:} %date%%{A}%{A}";
      };
    };
  };
}
