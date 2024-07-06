{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.addons.easy-move-plus-resize;
in {
  options.${namespace}.programs.graphical.addons.easy-move-plus-resize = {
    enable = mkBoolOpt false "Whether or not to enable Easy move+resize.";
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = ["easy-move-plus-resize"];
    };
  };
}
