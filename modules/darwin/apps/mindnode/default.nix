{
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.matrix.apps.mindnode;
in {
  options.matrix.apps.mindnode = with types; {
    enable = mkBoolOpt false "Whether or not to enable mindnode.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = true;
      masApps = {
        "mindnode" = 1289197285;
      };
    };
  };
}
