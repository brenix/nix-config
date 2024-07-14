{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.hugo;
in {
  options.${namespace}.programs.terminal.tools.hugo = {
    enable = mkBoolOpt false "Whether or not to enable hugo";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hugo
    ];
  };
}
