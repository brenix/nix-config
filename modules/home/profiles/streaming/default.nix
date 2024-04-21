{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.profiles.streaming;
in {
  options.profiles.streaming = with types; {
    enable = mkBoolOpt false "Whether or not to manage streaming configuration";
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
