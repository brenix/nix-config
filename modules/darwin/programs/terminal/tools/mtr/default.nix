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

  cfg = config.${namespace}.programs.terminal.tools.mtr;
in {
  options.${namespace}.programs.terminal.tools.mtr = {
    enable = mkBoolOpt false "Whether or not to enable mtr.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mtr
    ];
  };
}
