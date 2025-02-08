{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.ncmpcpp;
in {
  options.${namespace}.programs.terminal.tools.ncmpcpp = {
    enable = mkBoolOpt false "Whether or not install ncmpcpp";
  };

  config = mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;
    };
  };
}
