{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.python;
in {
  options.${namespace}.programs.terminal.tools.python = {
    enable = mkBoolOpt false "Whether or not install python tools";
  };

  config = mkIf cfg.enable {
    programs.poetry = {
      enable = true;
    };

    home.packages = with pkgs; [
      pipenv
    ];
  };
}
