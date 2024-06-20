{
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.matrix.apps.easy-move-plus-resize;
in {
  options.matrix.apps.easy-move-plus-resize = with types; {
    enable = mkBoolOpt false "Whether or not to enable Easy move+resize.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = ["easy-move-plus-resize"];
    };
  };
}
