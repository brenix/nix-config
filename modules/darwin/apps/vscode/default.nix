{ options, config, lib, pkgs, ... }:

with lib;
with lib.nixicle;
let cfg = config.nixicle.apps.vscode;
in
{
  options.nixicle.apps.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
    ];
  };
}
