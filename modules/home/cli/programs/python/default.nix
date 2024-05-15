{
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.programs.python;
in {
  options.cli.programs.python = with types; {
    enable = mkBoolOpt false "Whether or not install python tools";
  };

  config = mkIf cfg.enable {
    programs.poetry = {
      enable = true;
    };
  };
}
