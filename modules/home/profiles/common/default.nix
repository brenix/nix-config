{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib;
with inputs; let
  cfg = config.profiles.common;
in {
  imports = [
    catppuccin.homeManagerModules.catppuccin
    nix-colors.homeManagerModule
  ];

  options.profiles.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    colorscheme = nix-colors.colorSchemes.catppuccin-mocha;
    catppuccin.flavour = "mocha";

    browsers.firefox.enable = true;

    system = {
      nix.enable = true;
    };

    cli = {
      editors.helix.enable = true;
      multiplexers.tmux.enable = true;
      shells.fish.enable = true;

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

    security = {
      sops.enable = true;
    };

    # TODO move out
    home.packages = with pkgs; [
      gnumake
      gettext
      gcc
    ];
  };
}