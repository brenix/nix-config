{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.theme.qt;
in {
  options.${namespace}.theme.qt = {
    enable = mkBoolOpt false "enable qt theme management";
  };

  config = mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme.name = mkForce "kvantum";
      style.name = "kvantum";
    };
  };
}
