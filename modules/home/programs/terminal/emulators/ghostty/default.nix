{
  config,
  inputs,
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
    xdg.configFile."ghostty/config".text = ''
      font-family = "Berkeley Mono"
      command = fish
      gtk-titlebar = false
      font-size = 11.5
      font-style-bold = false
      font-style-italic = false
      font-style-bold-italic = false
      window-padding-x = 2
      window-padding-y = 2
      # copy-on-select = clipboard
      cursor-style = block
      adjust-cell-height = -5%
      freetype-load-flags = no-hinting,no-force-autohint
      term = xterm-256color
    '';

    home.packages = with inputs; [
      ghostty.packages.x86_64-linux.default
    ];
  };
}
