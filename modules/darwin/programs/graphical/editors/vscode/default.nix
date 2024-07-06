{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.editors.vscode;
in {
  options.${namespace}.programs.graphical.editors.vscode = {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
    ];
  };
}
