{ pkgs, ... }: {
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };

    settings = {
      global = {
        font = "NotoSans Nerd Font Regular 12";
        markup = "full";
        format = "<b>%s</b>\n%b";
        sort = "no";
        indicate_hidden = "yes";
        alignment = "left";
        show_age_threshold = -1;
        word_wrap = "yes";
        ignore_newline = "no";
        geometry = "300x50-16+51";
        transparency = 0;
        idle_threshold = 120;
        sticky_history = "yes";
        icon_position = "left";
        max_icon_size = 24;
        line_height = 0;
        separator_height = 2;
        padding = 5;
        horizontal_padding = 5;
        text_icon_padding = 10;
        separator_color = "frame";
        startup_notification = false;
        show_indicators = "no";
        frame_width = 1;
        corner_radius = 0;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";

        shadow-exclude = [
          "name = 'Notification'"
          "class_g ?= 'Dunst'"
          # disable shadows for hidden windows:
          "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
          #  "_GTK_FRAME_EXTENTS@:c",
          # disables shadows on sticky windows:
          "_NET_WM_STATE@:32a *= '_NET_WM_STATE_STICKY'"
        ];
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
      };

      urgency_low = {
        background = "#161821";
        foreground = "#d8dee9";
        timeout = 6;
      };

      urgency_normal = {
        background = "#161821";
        foreground = "#d8dee9";
        timeout = 10;
      };

      urgency_critical = {
        background = "#161821";
        foreground = "#ffffff";
        frame_color = "#bf616a";
        timeout = 0;
      };
    };
  };
}
