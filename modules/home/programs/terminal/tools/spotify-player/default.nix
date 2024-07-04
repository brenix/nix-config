{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.spotify-player;
in {
  options.${namespace}.programs.terminal.tools.spotify-player = {
    enable = mkBoolOpt false "Whether or not to enable spotify-player";
  };

  config = mkIf cfg.enable {
    programs = {
      spotify-player = {
        enable = true;
      };
    };
  };
}
