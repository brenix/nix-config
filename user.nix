{ pkgs, inputs, system, ... }: {

  imports = [
    ./home
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    LC_CTYPE = "en_US.UTF-8";
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
    authy
    autocutsel
    awless
    aws-vault
    awscli
    barrier
    bspwm
    buildah
    chamber
    cosign
    dconf
    discord
    dunst
    feh
    fluxcd
    go
    gomplate
    googler
    goreleaser
    grc
    gsimplecal
    guvcview
    handlr
    helmfile
    hugo
    kubectl
    kubernetes-helm
    kustomize
    lab
    lxappearance
    mr
    mupdf
    neovim
    nodePackages.npm
    nodePackages.prettier
    nodejs
    obconf
    openbox
    openconnect
    openrgb
    packer
    pavucontrol
    pcmanfm
    pgcli
    podman
    polybar
    python3
    python39Packages.pynvim   # nvim dep
    python39Packages.ueberzug # nvim dep
    ranger
    rnix-lsp
    rofi
    rofi-calc
    sd
    slack
    sops
    spotify
    starship
    stern
    sumneko-lua-language-server
    sxhkd
    sxiv
    theme-vertex
    vault-bin
    velero
    virt-manager
    win-virtio
    xclip
    zoom-us
  ];

  # Autocutsel
  systemd.user.services.autocutsel = {
    Unit.Description = "AutoCutSel";
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "forking";
      Restart = "always";
      RestartSec = 2;
      ExecStartPre = "${pkgs.autocutsel}/bin/autocutsel -fork";
      ExecStart = "${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork";
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

  # dircolors
  programs.dircolors.enable = true;

  # fzf
  programs.fzf = {
    enable = true;
    defaultOptions = [
      # nord colorscheme
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
  programs.gpg = {
    enable = true;
  };

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
    includes = [
      "~/.ssh/cells/config/*"
    ];
  };

}
