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
    mpv
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

  # Flameshot
  services.flameshot.enable = true;

}
