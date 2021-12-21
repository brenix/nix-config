{ config, pkgs, inputs, ... }: {

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ inputs.nix-colors.homeManagerModule ];
    users = {
      ${config.settings.username} = {
        imports = [
          ./alacritty
          ./dunst
          ./firefox
          ./git
          ./neovim
          ./openbox
          ./polybar
          ./rofi
          ./starship
          ./tmux
          ./zsh
        ];

        # Colorscheme
        # colorscheme = inputs.nix-colors.colorSchemes.nord;
        colorscheme = {
          slug = "nord-dark";
          name = "Nord-Dark";
          colors = {
            base00 = "161821";
            base01 = "2E3440";
            base02 = "3B4252";
            base03 = "4C566A";
            base04 = "D8DEE9";
            base05 = "E5E9F0";
            base06 = "ECEFF4";
            base07 = "8FBCBB";
            base08 = "BF616A";
            base09 = "D08770";
            base0A = "EBCB8B";
            base0B = "A3BE8C";
            base0C = "88C0D0";
            base0D = "81A1C1";
            base0E = "B48EAD";
            base0F = "5E81AC";
          };
        };

        # Enable home-manager
        programs.home-manager.enable = true;

        # X11
        xsession = {
          enable = true;
          pointerCursor = {
            package = pkgs.capitaine-cursors;
            name = "capitaine-cursors-white";
          };
        };

        # XDG
        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            documents = "$HOME/downloads/documents/";
            download = "$HOME/downloads/";
            videos = "$HOME/downloads/videos/";
            music = "$HOME/downloads/music/";
            pictures = "$HOME/downloads/pictures/";
            desktop = "$HOME/downloads/desktop/";
            publicShare = "$HOME/downloads/public/";
            templates = "$HOME/downloads/templates/";
          };
        };

        # Packages to be installed
        home.packages = with pkgs; [
          asdf-vm
          authy
          awless
          aws-vault
          awscli
          buildah
          chamber
          dconf # gtk dep
          discord
          feh
          fluxcd
          git-ignore
          gomplate
          googler
          goreleaser
          grc
          guvcview
          handlr
          helmfile
          hugo
          kubectl
          kubernetes-helm
          kustomize
          lab
          lefthook
          lxappearance
          mr
          mupdf
          nodePackages.npm
          nodejs
          openrgb
          packer
          pavucontrol
          pcmanfm
          pgcli
          pipenv
          piper
          sd
          slack
          sops
          spotify
          stern
          sxiv
          terraform
          theme-vertex
          unrar
          unzip
          vault-bin
          velero
          xclip
          zoom-us
        ];

        # Autocutsel
        systemd.user.services.autocutsel = {
          Unit.Description = "AutoCutSel";
          Install = { WantedBy = [ "default.target" ]; };
          Service = {
            Type = "forking";
            Restart = "always";
            RestartSec = 2;
            ExecStartPre = "${pkgs.autocutsel}/bin/autocutsel -fork";
            ExecStart =
              "${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork";
          };
        };

        # bat
        programs.bat = {
          enable = true;
          config = {
            theme = "ansi";
            pager = "less -inMRF";
          };
        };

        # fzf
        programs.fzf = {
          enable = true;
          defaultOptions = [
            "--color=fg:#e5e9f0,bg:#191c26,hl:#a3be8b"
            "--color=fg+:#e5e9f0,bg+:#191c26,hl+:#a3be8b"
            "--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac"
            "--color=marker:#81a1c1,spinner:#b48dac,header:#81a1c1"
          ];
        };

        # go
        programs.go = {
          enable = true;
          goPath = "go";
        };

        # GTK
        gtk = {
          enable = true;
          font = {
            package = pkgs.corefonts;
            name = "Verdana";
            size = 10;
          };
          iconTheme = {
            package = pkgs.arc-icon-theme;
            name = "Arc";
          };
          theme = {
            package = pkgs.arc-theme;
            name = "Arc";
          };
        };

        # GPG
        programs.gpg = { enable = true; };
        services.gpg-agent.enable = true;

        # htop
        programs.htop = {
          enable = true;
          settings = {
            sort_direction = true;
            sort_key = "PERCENT_CPU";
          };
        };

        # flameshot
        services.flameshot = {
          enable = true;
          settings = {
            General = {
              disabledTrayIcon = true;
              showStartupLaunchMessage = false;
            };
          };
        };

        # jq
        programs.jq.enable = true;

        # disable man pages
        programs.man.enable = false;

        # mpv
        programs.mpv.enable = true;

        # playerctl
        services.playerctld.enable = true;

        # unclutter
        services.unclutter.enable = true;

        # ssh
        programs.ssh = {
          enable = true;
          includes = [ "~/.ssh/cells/config/*" ];
        };

        # terraform
        home.file.".terraformrc".text = ''
          plugin_cache_dir = "$HOME/.cache/terraform-plugin-cache"
          disable_checkpoint = true
        '';
        systemd.user.tmpfiles.rules = [
          "d $HOME/.cache/terraform-plugin-cache 0755 ${config.settings.username} users"
        ];
      };
    };
  };
}
