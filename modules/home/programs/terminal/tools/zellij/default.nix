{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.zellij;
in {
  options.${namespace}.programs.terminal.tools.zellij = {
    enable = mkBoolOpt false "Whether or not to enable zellij.";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      settings = {
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
            "bind \"Alt '\"" = {
              NewTab = [];
            };
          };
        };

        # load internal plugins from built-in paths
        plugins = {
          tab-bar.path = "tab-bar";
          status-bar.path = "status-bar";
          strider.path = "strider";
          compact-bar.path = "compact-bar";
        };

        themes.stylix = with config.lib.stylix.colors.withHashtag; {
          bg = mkForce base00;
          fg = mkForce base05;
          white = mkForce base05;
          green = mkForce base0D;
        };
      };
    };
  };
}
