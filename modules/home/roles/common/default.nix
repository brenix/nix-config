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

    # We do things on the bleeding edge around here..
    home.enableNixpkgsReleaseCheck = false;

    stylix = {
      enable = true;
      # -- Mashup
      # polarity = "dark";
      # base16Scheme = {
      #   base00 = "161617"; # background
      #   base01 = "27272a"; # dark gray
      #   base02 = "353539"; # gray
      #   base03 = "464649"; # light gray
      #   base04 = "909095"; # secondary
      #   base05 = "c9c7cd"; # foreground
      #   base06 = "a4a3a8"; # lighter gray
      #   base07 = "c9c7cd"; # white
      #   base08 = "ea83a5"; # red
      #   # base08 = "fc5d7c"; # red
      #   base09 = "e6b99d"; # orange
      #   base0A = "e6dc9d"; # yellow
      #   base0B = "90b99f"; # green
      #   base0C = "85b5ba"; # cyan
      #   base0D = "9cb2cf"; # blue
      #   base0E = "ae9ee2"; # magenta
      #   base0F = "ab9c93"; # brown
      # };

      # -- Sonokai
      # polarity = "dark";
      # base16Scheme = {
      #   base00 = "2c2e34"; # background
      #   base01 = "33353f"; # dark gray
      #   base02 = "363944"; # gray
      #   base03 = "3b3e48"; # light gray
      #   base04 = "414550"; # secondary
      #   base05 = "e2e2e3"; # foreground
      #   base06 = "595f6f"; # lighter gray
      #   base07 = "7f8490"; # white
      #   base08 = "fc5d7c"; # red
      #   base09 = "f39660"; # orange
      #   base0A = "e7c664"; # yellow
      #   base0B = "9ed072"; # green
      #   base0C = "76cce0"; # cyan
      #   base0D = "85d3f2"; # blue
      #   base0E = "b39df3"; # magenta
      #   base0F = "4e432f"; # brown
      # };

      # -- Nord
      # polarity = "dark";
      # base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      # override = {
      #   base00 = "252933";
      #   base04 = "C0C5CF";
      # };

      # -- Modus operandi
      polarity = "light";
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

      image = "${pkgs.${namespace}.wallpapers.cracks}";

      targets = {
        gtk.enable = false;
        helix.enable = false;
        k9s.enable = false;
        vscode.enable = false;
        waybar.enable = false;
      };

      fonts = {
        sizes = {
          desktop = 12;
          applications = 12;
          terminal = 12;
          popups = 12;
        };

        sansSerif = {
          package = pkgs.inter;
          name = "Inter";
        };

        serif = config.stylix.fonts.sansSerif;

        monospace = {
          # package = pkgs.matrix.berkeley-mono;
          # name = "BerkeleyMono Nerd Font Mono";

          # package = pkgs.azeret-mono;
          # name = "Azeret Mono";

          package = pkgs.terminus_font;
          name = "Terminus";
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
            tmux.enable = true;
            yazi.enable = true;
            zellij.enable = false;
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

    home.packages = with pkgs; [
      matrix.bins
    ];
  };
}
