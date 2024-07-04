{
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  cfg = config.${namespace}.programs.graphical.apps.mindnode;
in {
  options.${namespace}.programs.graphical.apps.mindnode = with types; {
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
