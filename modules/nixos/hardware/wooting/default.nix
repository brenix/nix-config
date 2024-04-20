{ options
, config
, lib
, ...
}:
with lib;
with lib.nixicle; let
  cfg = config.hardware.wooting;
in
{
  options.hardware.wooting = with types; {
    enable = mkBoolOpt false "Enable support for wooting keyboards";
  };

  config = mkIf cfg.enable {
    hardware.keyboard.wooting.enable = true;
  };
}
