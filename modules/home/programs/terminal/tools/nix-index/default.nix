{
  config,
  inputs,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.nix-index;
in {
  options.${namespace}.programs.terminal.tools.nix-index = {
    enable = mkBoolOpt false "Whether or not to nix index";
  };

  imports = with inputs; [
    nix-index-database.hmModules.nix-index
  ];

  config = mkIf cfg.enable {
    programs.nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
    programs.nix-index-database.comma.enable = true;
  };
}
