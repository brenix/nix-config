{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.theme.gtk;
in {
  options.${namespace}.theme.gtk = {
    enable = mkBoolOpt false "enable gtk theme management";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
    };
  };
}
