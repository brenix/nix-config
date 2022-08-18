{ pkgs, ... }:
{
  imports = [
    ./neovim
    ./zsh
    ./bat.nix
    ./dircolors.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./go.nix
    ./kubernetes.nix
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
    awless
    aws-vault
    awscli2
    calicoctl
    certigo
    comma
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
    hugo
    lefthook
    mr
    nodePackages.npm
    nodejs
    packer
    pipenv
    python310
    reftools
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

  programs.jq.enable = true;
}
