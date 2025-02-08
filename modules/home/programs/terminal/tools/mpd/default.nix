{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.mpd;
in {
  options.${namespace}.programs.terminal.tools.mpd = {
    enable = mkBoolOpt false "Whether or not install mpd";
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      network.startWhenNeeded = true;
    };
  };
}
