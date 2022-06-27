{ config, pkgs, inputs, lib, ... }: {

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ inputs.nix-colors.homeManagerModule ];
    users.brenix = {
      imports = [
        ./alacritty
        ./bspwm
        ./dunst
        ./firefox
        ./git
        ./neovim
        ./polybar
        ./rofi
        ./starship
        ./sxhkd
        ./tmux
        ./shell
      ];

      # Colorscheme
      /* colorscheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-hard; */
      /* colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "nord-dark" (builtins.readFile ./colorschemes/nord-dark.yaml); */
      colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "gruvbox-material" (builtins.readFile ./colorschemes/gruvbox-material-dark-hard.yaml);

      # Enable home-manager
      programs.home-manager.enable = true;

      # X11
      xsession = lib.mkIf config.services.xserver.enable { enable = true; };

      # Fontconfig
      fonts.fontconfig = lib.mkIf config.services.xserver.enable { enable = true; };

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
        #awless
        #buildah
        #chamber
        #handlr
        #lxappearance
        #openrgb
        #pcmanfm
        #protonup
        #velero
        age
        asdf-vm
        authy
        aws-vault
        awscli2
        calicoctl
        certigo
        dash-font
        discord
        feh
        fluxcd
        fx
        git-ignore
        glab
        go-tools
        golangci-lint
        gomplate
        gopls
        goreleaser
        gotools
        grc
        helmfile
        hugo
        imv
        krew
        kubectl
        kubernetes-helm
        kustomize
        lefthook
        mr
        mullvad-vpn
        mupdf
        nodePackages.npm
        nodejs
        packer
        pamixer
        pavucontrol
        pgcli
        pipenv
        piper
        playerctl
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
        tewi-font
        theme-vertex
        unrar
        unzip
        vault-bin
        vendir
        xclip
        yq-go
        zoom-us
        zoxide
      ];

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
          size = 9;
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

      # disable man pages
      programs.man.enable = false;

      # mpv
      programs.mpv =
        lib.mkIf config.services.xserver.enable { enable = true; };

      # playerctl
      services.playerctld.enable = true;

      # unclutter
      services.unclutter = lib.mkIf config.services.xserver.enable { enable = true; };

      # picom
      services.picom = {
        enable = true;
        activeOpacity = "1.0";
        inactiveOpacity = "1.0";
        shadow = true;
        fade = false;
        blur = true;
        backend = "glx";
        /* opacityRule = [ */
        /*   "80:class_i ?= 'alacritty'" */
        /*   "80:class_i ?= 'floating'" */
        /*   "80:class_i ?= 'polybar'" */
        /* ]; */
      };

      # myrepos
      home.file.".mrconfig".text = ''
        [DEFAULT]
        jobs = 5
        git_update = git pull --prune --tags "$@"
        git_fetch = git fetch --prune --prune-tags
        git_gc = git gc --aggressive "$@"
        git_tags = git tag -l
        git_branches = git branch
        branch = printf "\e[1;33m%-6s\e[m\n" $(git rev-parse --abbrev-ref HEAD)
        default = git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
        reset = git reset --hard HEAD && git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') && git clean -d -f
      '';

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

      # create common directories
      systemd.user.tmpfiles.rules = [
        "d %h/.cache/terraform-plugin-cache 0755"
        "d %h/.kube 0700"
        "d %h/work 0755"
      ];

      # Reload system units when changing configs
      systemd.user.startServices = "sd-switch";

      home.stateVersion = "21.05";
    };
  };
}
