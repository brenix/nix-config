{ config, pkgs, inputs, lib, ... }: {

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ inputs.nix-colors.homeManagerModule ];
    users = {
      ${config.settings.username} = {
        imports = [
          ./alacritty
          ./bspwm
          ./dunst
          ./firefox
          ./git
          ./neovim
          #./openbox
          ./polybar
          ./rofi
          ./starship
          ./sxhkd
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
        xsession = lib.mkIf config.services.xserver.enable {
          enable = true;
        };

        # Fontconfig
        fonts.fontconfig =
          lib.mkIf config.services.xserver.enable { enable = true; };

        # XDG
        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            documents = "$XDG_RUNTIME_DIR/documents/";
            download = "$HOME/downloads";
            videos = "$XDG_RUNTIME_DIR/videos/";
            music = "$XDG_RUNTIME_DIR/music/";
            pictures = "$XDG_RUNTIME_DIR/pictures/";
            desktop = "$XDG_RUNTIME_DIR/desktop/";
            publicShare = "$XDG_RUNTIME_DIR/public/";
            templates = "$XDG_RUNTIME_DIR/templates/";
          };
        };

        # Fix issue with capslock->escape xkb option (https://github.com/NixOS/nixpkgs/issues/18173#issuecomment-954207948)
        home.keyboard = null;

        # Dirs to add to PATH
        home.sessionPath =
          [ "$HOME/.local/bin" "$HOME/.krew/bin" "$HOME/go/bin" ];

        # Packages to be installed
        home.packages = with pkgs; [
          age
          asdf-vm
          authy
          awless
          aws-vault
          awscli2
          blanket
          buildah
          calicoctl
          certigo
          chamber
          cool-retro-term
          discord
          feh
          fluxcd
          git-ignore
          glab
          golangci-lint
          go-tools
          gomplate
          googler
          gopls
          goreleaser
          gotools
          grc
          handlr
          helmfile
          hugo
          krew
          kubectl
          kubernetes-helm
          kustomize
          lefthook
          lxappearance
          mr
          mullvad-vpn
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
          playerctl
          protonup
          python310
          reftools
          sd
          shfmt
          slack
          sops
          spotify
          stern
          sxiv
          terraform
          terraform-docs
          theme-vertex
          unrar
          unzip
          vault-bin
          velero
          vendir
          xclip
          yq-go
          zoom-us
          zoxide
        ];

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
          package = pkgs.go_1_18;
          goPath = "go";
          goBin = "go/bin";
        };

        # GTK
        gtk = lib.mkIf config.services.xserver.enable {
          enable = true;
          cursorTheme = {
            package = pkgs.capitaine-cursors;
            name = "capitaine-cursors-white";
          };
          font = {
            package = pkgs.corefonts;
            name = "Verdana";
            size = 10;
          };
          iconTheme = {
            package = pkgs.nordzy-icon-theme;
            name = "Nordzy";
          };
          theme = {
            package = pkgs.arc-theme;
            name = "Arc";
          };
        };

        # GPG
        programs.gpg.enable = true;
        services.gpg-agent.enable = true;
        services.gpg-agent.pinentryFlavor = "curses";

        # htop
        programs.htop = {
          enable = true;
          settings = {
            sort_direction = true;
            sort_key = "PERCENT_CPU";
          };
        };

        # flameshot
        services.flameshot = lib.mkIf config.services.xserver.enable {
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

        # direnv
        programs.direnv.enable = true;

        # disable man pages
        programs.man.enable = false;

        # mpv
        programs.mpv =
          lib.mkIf config.services.xserver.enable { enable = true; };

        # playerctl
        services.playerctld.enable = true;

        # unclutter
        services.unclutter =
          lib.mkIf config.services.xserver.enable { enable = true; };

        # ssh
        programs.ssh = {
          enable = true;
          includes = [ "~/.ssh/cells/config/*" "~/.ssh/config.local" ];
        };

        # terraform
        home.file.".terraformrc".text = ''
          plugin_cache_dir = "$HOME/.cache/terraform-plugin-cache"
          disable_checkpoint = true
        '';
        systemd.user.tmpfiles.rules = [
          "d /home/${config.settings.username}/.cache/terraform-plugin-cache 0755 ${config.settings.username} users"
        ];
      };
    };
  };
}
