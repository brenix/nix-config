{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.discord;
in {
  options.programs.discord = {
    enable = mkEnableOption "Enable discord program";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord-krisp # chaotic-nyx
    ];
  };
}
