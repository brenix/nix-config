{ pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./colorscheme.nix
    ./containers.nix
    ./dircolors.nix
    ./fzf.nix
    ./git.nix
    ./home-manager.nix
    ./impermanence.nix
    ./man-pages.nix
    ./nix-index.nix
    ./nix.nix
    ./services.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./xresources.nix
    ./zsh
  ];

  home.packages = with pkgs; [
    # nodePackages.npm
    # nodejs
    age
    awless
    aws-vault
    awscli2
    certigo
    chamber
    comma
    glab
    go-task
    gojq
    gomplate
    graphviz
    grc
    htop
    hugo
    imagemagick
    jwt-cli
    lefthook
    packer
    parallel
    pipenv
    python311
    sd
    shfmt
    sops
    unrar
    unzip
    vault-bin
    velero
    vendir
    wireguard-tools
    yq-go
    zoxide
  ];

}
