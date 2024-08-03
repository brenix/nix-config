{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.roles.common;
in {
  options.${namespace}.roles.common = {
    enable = mkBoolOpt false "Enable common configuration";
  };

  config = mkIf cfg.enable {
    # catppuccin.flavor = "mocha";
    # xdg.enable = pkgs.stdenv.isLinux; # required by catppuccin module

    stylix = {
      enable = true;
      polarity = "light";

      # modus-operandi
      base16Scheme = {
        base00 = "ffffff"; # background
        base01 = "fefefe"; # dark gray
        base02 = "e1e4e8"; # gray
        base03 = "d1d5da"; # light gray
        base04 = "585858"; # secondary
        base05 = "000000"; # foreground
        base06 = "f4dbd6"; # lighter gray
        base07 = "b7bdf8"; # white
        base08 = "a60000"; # red
        base09 = "f66a0a"; # orange
        base0A = "6f5500"; # yellow
        base0B = "006800"; # green
        base0C = "005e8b"; # cyan
        base0D = "0031a9"; # blue
        base0E = "721045"; # magenta
        base0F = "8a290f"; # brown
      };

      image = "${pkgs.${namespace}.wallpapers.nixos-dark}";

      targets = {
        helix.enable = false;
        k9s.enable = false;
        vscode.enable = false;
        waybar.enable = false;
      };

      fonts = {
        sizes = {
          desktop = 10;
          applications = 10;
          terminal = 10;
          popups = 10;
        };

        sansSerif = {
          package = pkgs.inter;
          name = "Inter";
        };

        serif = config.stylix.fonts.sansSerif;

        monospace = with pkgs; {
          # package = pkgs.gohufont;
          package = nerdfonts.override {fonts = ["JetBrainsMono"];};
          name = "JetBrainsMono NF Light";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };

    matrix = {
      programs = {
        terminal = {
          editors.helix.enable = true;
          editors.language-servers.enable = true;
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
            zellij.enable = true;
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
