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
    go-task
    go-tools
    gojq
    golangci-lint
    gomplate
    gopls
    goreleaser
    gotools
    grc
    htop
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
    tfenv
    unrar
    unzip
    vault-bin
    velero
    vendir
    wireguard-tools
    yq-go
    zoxide
  ];

  programs.jq = {
    enable = true;
  };


  xdg.configFile."containers/storage.conf".text = ''
    [storage]
    driver = "btrfs"
    runroot = "/run/user/1000"
    graphroot = "/home/brenix/.containers/storage"
  '';
}
