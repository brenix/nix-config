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

  cfg = config.${namespace}.programs.graphical.emulators.iterm2;
in {
  options.${namespace}.programs.graphical.emulators.iterm2 = {
    enable = mkBoolOpt false "Whether or not to enable iTerm2.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      iterm2
    ];
  };
}
