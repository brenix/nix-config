{
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  cfg = config.${namespace}.programs.graphical.addons.easy-move-plus-resize;
in {
  options.${namespace}.programs.graphical.addons.easy-move-plus-resize = with types; {
    enable = mkBoolOpt false "Whether or not to enable Easy move+resize.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = ["easy-move-plus-resize"];
    };
  };
}
