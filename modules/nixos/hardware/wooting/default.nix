{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.wooting;
in {
  options.${namespace}.hardware.wooting = {
    enable = mkBoolOpt false "Enable support for wooting keyboards";
  };

  config = mkIf cfg.enable {
    hardware.wooting.enable = true;
  };
}
