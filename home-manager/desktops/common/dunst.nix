{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.wms.notifications.dunst;
in
{
  options.modules.wms.notifications.dunst = {
    enable = mkEnableOption "enable dunst notification manager";
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;

      iconTheme = {
        name = "Paper";
        package = pkgs.paper-icon-theme;
      };

      settings = {
        global = {
          font = "${config.my.settings.fonts.regular} 10";
          markup = "full";
          follow = "none";
          format = ''
            <b>%s</b>
            %b'';
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
            "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'" # disable shadows for hidden windows
            "_NET_WM_STATE@:32a *= '_NET_WM_STATE_STICKY'" # disables shadows on sticky windows
          ];
        };

        shortcuts = {
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
        };

        urgency_low = {
          background = "#${config.colorscheme.palette.base00}";
          foreground = "#${config.colorscheme.palette.base05}";
          timeout = 6;
        };

        urgency_normal = {
          background = "#${config.colorscheme.palette.base00}";
          foreground = "#${config.colorscheme.palette.base05}";
          timeout = 10;
        };

        urgency_critical = {
          background = "#${config.colorscheme.palette.base00}";
          foreground = "#${config.colorscheme.palette.base05}";
          frame_color = "#${config.colorscheme.palette.base08}";
          timeout = 0;
        };
      };
    };
  };
}
