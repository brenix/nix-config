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
    home.enableNixpkgsReleaseCheck = false;

    catppuccin = {
      enable = false;
      flavor = "mocha";
      accent = "blue";

      k9s.transparent = true;

      gtk = {
        enable = false;
        size = "compact";
        tweaks = ["rimless"];
      };

      tmux = {
        enable = false;
        extraConfig = ''
          set -g @catppuccin_status_modules_right "application session user host date_time"
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
        '';
      };
    };

    stylix = {
      enable = true;
      autoEnable = true;
      polarity = "dark";
      base16Scheme = import ./themes/oldschool.nix;
      # base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      # override = {
      #   base00 = "252933";
      #   base04 = "C0C5CF";
      # };
      image = "${pkgs.${namespace}.wallpapers.blacksquares}";
      targets = {
        fnott.enable = false;
        gtk.enable = false;
        helix.enable = false;
        hyprland.enable = false;
        k9s.enable = false;
        vscode.enable = false;
        waybar.enable = false;

        # selectively enable when autoEnable=false
        hyprpaper.enable = true;
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
          package = pkgs.matrix.berkeley-mono;
          name = "Berkeley Mono";
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
            dircolors.enable = false;
            direnv.enable = true;
            fzf.enable = true;
            git.enable = true;
            htop.enable = false;
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
