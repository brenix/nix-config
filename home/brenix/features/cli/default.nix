{ pkgs, ... }:
{
  imports = [
    ./zsh
    ./bat.nix
    ./dircolors.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./myrepos.nix
    ./nix-index.nix
    ./ssh.nix
    ./starship.nix
    ./terraform.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    # aiac
    age
    awless
    aws-vault
    awscli2
    calicoctl
    certigo
    comma
    glab
    go-task
    gojq
    gomplate
    grc
    htop
    hugo
    lefthook
    # nodePackages.npm
    # nodejs
    packer
    pipenv
    python311
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
