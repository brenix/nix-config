{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.apps.discord;
in {
  options.${namespace}.programs.graphical.apps.discord = {
    enable = mkBoolOpt false "Enable discord";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord-krisp # chaotic-nyx
    ];
  };
}
