{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib;
with inputs; let
  cfg = config.roles.common;
in {
  imports = [
    catppuccin.homeManagerModules.catppuccin
    nix-colors.homeManagerModule
  ];

  options.roles.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    colorscheme = nix-colors.colorSchemes.catppuccin-mocha;
    catppuccin.flavour = "mocha";

    system = {
      nix.enable = true;
    };

    cli = {
      editors.helix.enable = true;
      multiplexers.tmux.enable = true;
      shells.fish.enable = true;

      programs = {
        bat.enable = true;
        common.enable = true;
        dircolors.enable = true;
        direnv.enable = true;
        fzf.enable = true;
        git.enable = true;
        k8s.enable = true;
        nix-index.enable = true;
        ssh.enable = true;
        starship.enable = true;
        yazi.enable = true;
        zoxide.enable = true;
      };
    };

    programs = {
      gh.enable = true;
    };

    security = {
      sops.enable = true;
    };
  };
}
