{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.editors.vscode;
in
{
  options.modules.editors.vscode = {
    enable = mkEnableOption "enable vscode editor";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };

    home.persistence = {
      "/persist/home/brenix" = {
        directories = [ ".config/VSCodium" ".vscode-oss" ];
        allowOther = true;
      };
    };
  };
}
