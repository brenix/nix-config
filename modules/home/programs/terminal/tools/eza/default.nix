{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.eza;
in {
  options.${namespace}.programs.terminal.tools.eza = {
    enable = mkBoolOpt false "Whether or not to enable eza";
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
    };
  };
}
