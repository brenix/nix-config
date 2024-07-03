{
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.multiplexers.zellij;
  inherit (config.colorscheme) palette;
in {
  options.cli.multiplexers.zellij = {
    enable = mkBoolOpt false "Whether or not to enable zellij.";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        # theme = "nix-colors";
        auto_layouts = false;
        default_layout = "compact";
        on_force_close = "quit";
        pane_frames = false;
        mouse_mode = false;
        pane_viewport_serialization = true;
        scrollback_lines_to_serialize = 1000;
        session_serialization = true;

        ui.pane_frames = {
          rounded_corners = false;
          hide_session_name = true;
        };

        keybinds = {
          unbind = "Ctrl h";
          normal = {
            "bind \"Alt N\"" = {
              NewPane = ["Down"];
            };
            "bind \"Alt H\"" = {
              Resize = ["Left"];
            };
            "bind \"Alt J\"" = {
              Resize = ["Down"];
            };
            "bind \"Alt K\"" = {
              Resize = ["Up"];
            };
            "bind \"Alt L\"" = {
              Resize = ["Right"];
            };
            "bind \"Alt v\"" = {
              ToggleActiveSyncTab = [];
            };
            "bind \"Alt d\"" = {
              Detach = [];
            };
            "bind \"Alt f\"" = {
              ToggleFocusFullscreen = [];
            };
          };
        };

        themes = {
          nix-colors = {
            fg = "#${palette.base05}";
            bg = "#1d2021";
            black = "#282828";
            red = "#${palette.base08}";
            green = "#${palette.base0B}";
            yellow = "#${palette.base0A}";
            blue = "#${palette.base0D}";
            magenta = "#${palette.base0E}";
            cyan = "#${palette.base0C}";
            white = "#${palette.base05}";
            orange = "#${palette.base0A}";
          };
        };

        # load internal plugins from built-in paths
        plugins = {
          tab-bar.path = "tab-bar";
          status-bar.path = "status-bar";
          strider.path = "strider";
          compact-bar.path = "compact-bar";
        };
      };
    };
  };
}
