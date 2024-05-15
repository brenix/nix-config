{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.vscodium;
in {
  options.programs.vscodium = {
    enable = mkEnableOption "Enable vscodium";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };
}
