{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.profiles.development;
in {
  options.profiles.development = {
    enable = mkEnableOption "Enable development configuration";
  };

  config = mkIf cfg.enable {
    profiles.common.enable = true;

    cli = {
      editors.helix.enable = true;
      multiplexers.tmux.enable = true;

      programs = {
        bat.enable = true;
        direnv.enable = true;
        fzf.enable = true;
        git.enable = true;
        k8s.enable = true;
        modern-unix.enable = true;
        network-tools.enable = true;
        nix-index.enable = true;
        ssh.enable = true;
        starship.enable = true;
        yazi.enable = true;
        zoxide.enable = true;
      };
    };
  };
}
