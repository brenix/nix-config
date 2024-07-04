{
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.programs.yazi;
in {
  options.cli.programs.yazi = with types; {
    enable = mkBoolOpt false "Whether or not to enable yazi";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      catppuccin.enable = true;
      enableFishIntegration = true;
    };
  };
}
