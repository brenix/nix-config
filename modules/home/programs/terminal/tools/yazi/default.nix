{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.yazi;
in {
  options.${namespace}.programs.terminal.tools.yazi = {
    enable = mkBoolOpt false "Whether or not to enable yazi";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      catppuccin.enable = true;
      enableFishIntegration = true;
    };
  };
}
