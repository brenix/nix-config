{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib; let
  cfg = config.${namespace}.programs.graphical.emulators.iterm2;
in {
  options.${namespace}.programs.graphical.emulators.iterm2 = with types; {
    enable = mkBoolOpt false "Whether or not to enable iTerm2.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      iterm2
    ];
  };
}
