{ pkgs, ... }:
{
  imports = [
    ./neovim
    ./zsh
    ./bat.nix
    ./dircolors.nix
    ./fzf.nix
    ./git.nix
    ./go.nix
    ./myrepos.nix
    ./nix-index.nix
    ./pfetch.nix
    ./ssh.nix
    ./starship.nix
    ./terraform.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    age
    aws-vault
    awscli2
    calicoctl
    certigo
    comma
    envsubst
    fluxcd
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
    krew
    kubectl
    kubernetes-helm
    kustomize
    lefthook
    mr
    nodePackages.npm
    nodejs
    packer
    pgcli
    pipenv
    python310
    reftools
    sd
    shfmt
    sops
    stern
    unrar
    unzip
    vault-bin
    velero
    vendir
    wireguard-tools
    yq-go
    zoxide
  ];

  programs.jq.enable = true;
}
