{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.hardware.wootingKeyboard;
in {
  options.hardware.wootingKeyboard = with types; {
    enable = mkBoolOpt false "Enable support for wooting keyboards";
  };

  config = mkIf cfg.enable {
    hardware.wooting.enable = true;
  };
}
