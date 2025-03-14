{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.ghostty;
in {
  options.${namespace}.programs.terminal.emulators.ghostty = {
    enable = mkBoolOpt false "enable ghostty terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        # font-family = config.stylix.fonts.monospace.name;
        font-family = "Berkeley Mono";
        command = "fish";
        gtk-titlebar = "false";
        font-size = 14;
        font-style-bold = false;
        font-style-italic = false;
        font-style-bold-italic = false;
        window-padding-x = 2;
        window-padding-y = 2;
        copy-on-select = "clipboard";
        cursor-style = "block";
        adjust-cell-width = "-3%";
        adjust-cell-height = "-15%";
        freetype-load-flags = "no-autohint,no-force-autohint";
        term = "xterm-256color";
        app-notifications = false;
      };
    };
  };
}
