{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib; let
  cfg = config.${namespace}.programs.terminal.tools.mtr;
in {
  options.${namespace}.programs.terminal.tools.mtr = with types; {
    enable = mkBoolOpt false "Whether or not to enable mtr.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mtr
    ];
  };
}
