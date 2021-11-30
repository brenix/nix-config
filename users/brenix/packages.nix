{ config, pkgs, ... }: {

  # Allow unfree packages to be installed
  nixpkgs.config.allowUnfree = true;

  # Packages to be installed
  environment.systemPackages = with pkgs; [
    autocutsel
    awless
    aws-vault
    awscli
    barrier
    bspwm
    buildah
    chamber
    cosign
    discord
    dunst
    feh
    flameshot
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
