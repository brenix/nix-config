{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.fzf;
in {
  options.${namespace}.programs.terminal.tools.fzf = {
    enable = mkBoolOpt false "Whether or not to enable fzf";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      # catppuccin.enable = true;
      colors = with config.lib.stylix.colors.withHashtag; {
        "bg+" = mkForce base00;
        "fg+" = mkForce base0D;
      };

      defaultOptions = [
        "--layout=reverse"
      ];
    };
  };
}
