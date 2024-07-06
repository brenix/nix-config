{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.apps.mindnode;
in {
  options.${namespace}.programs.graphical.apps.mindnode = {
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
