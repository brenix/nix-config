{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.gomplate;
in {
  options.${namespace}.programs.terminal.tools.gomplate = {
    enable = mkBoolOpt false "Whether or not to enable gomplate";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gomplate
    ];
  };
}
