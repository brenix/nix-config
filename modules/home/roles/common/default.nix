{
  config,
  inputs,
  lib,
  namespace,
  ...
}:
with inputs; let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.roles.common;
in {
  imports = [
    catppuccin.homeManagerModules.catppuccin
    nix-colors.homeManagerModule
  ];

  options.${namespace}.roles.common = {
    enable = mkBoolOpt false "Enable common configuration";
  };

  config = mkIf cfg.enable {
    colorscheme = nix-colors.colorSchemes.catppuccin-mocha;
    # colorscheme = nix-colors.colorSchemes.gruvbox-material-dark-hard;
    catppuccin.flavor = "mocha";
    xdg.enable = true; # required by catppuccin module

    matrix = {
      programs = {
        terminal = {
          editors.helix.enable = true;
          shells.fish.enable = true;
          tools = {
            atuin.enable = false;
            bat.enable = true;
            common.enable = true;
            dircolors.enable = true;
            direnv.enable = true;
            fzf.enable = true;
            git.enable = true;
            htop.enable = true;
            k8s.enable = true;
            nix-index.enable = true;
            ssh.enable = true;
            starship.enable = true;
            zoxide.enable = true;
          };
        };
      };

      security.sops.enable = true;

      system = {
        nix.enable = true;
      };
    };

    programs = {
      gh.enable = true;
    };
  };
}
