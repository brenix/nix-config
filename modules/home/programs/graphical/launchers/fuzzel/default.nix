{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (lib.${namespace}) mkBoolOpt mkPackageOpt;

  cfg = config.${namespace}.programs.graphical.launchers.fuzzel;
in {
  options.${namespace}.programs.graphical.launchers.fuzzel = {
    enable = mkBoolOpt false "Enable fuzzel launcher";
    package = mkPackageOpt pkgs.fuzzel "Package to use for fuzzel";
  };

  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      package = cfg.package;
      settings.main.font = mkForce "${config.stylix.fonts.monospace.name}:size=${toString config.stylix.fonts.sizes.popups}";
    };
  };
}
