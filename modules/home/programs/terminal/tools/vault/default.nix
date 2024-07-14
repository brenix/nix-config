{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.vault;
in {
  options.${namespace}.programs.terminal.tools.vault = {
    enable = mkBoolOpt false "Whether or not to enable vault";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      vault-bin
    ];
  };
}
