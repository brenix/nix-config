{ config, pkgs, ... }: {

  # Allow unfree packages to be installed
  #nixpkgs.config.allowUnfree = true;

  # Allow insecure packages
  #nixpkgs.config.permittedInsecurePackages = [
  #  # needed for authy
  #  "electron-9.4.4"
  #];

  # Packages to be installed
  home.packages = with pkgs; [
    #authy
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
    lxappearance
    mpv
    mr
    mupdf
    neovim
    nodePackages.prettier
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
    ranger
    rnix-lsp
    rofi
    rofi-calc
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
}
