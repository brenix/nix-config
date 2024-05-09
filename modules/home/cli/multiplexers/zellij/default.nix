{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.multiplexers.zellij;
in {
  options.cli.multiplexers.zellij = {
    enable = mkBoolOpt false "Whether or not to enable zellij.";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      catppuccin.enable = true;

      settings = {
        copy_command =
          if pkgs.stdenv.isLinux
          then "wl-copy"
          else if pkgs.stdenv.isDarwin
          then "pbcopy"
          else "";

        auto_layouts = true;
        default_layout = "compact";
        on_force_close = "quit";
        pane_frames = true;
        pane_viewport_serialization = true;
        scrollback_lines_to_serialize = 1000;
        session_serialization = true;

        ui.pane_frames = {
          rounded_corners = true;
          hide_session_name = true;
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
