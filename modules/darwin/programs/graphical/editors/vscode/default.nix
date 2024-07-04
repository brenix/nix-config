{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib; let
  cfg = config.${namespace}.programs.graphical.editors.vscode;
in {
  options.${namespace}.programs.graphical.editors.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
    ];
  };
}
