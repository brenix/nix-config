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
    # nodePackages.npm
    # nodejs
    age
    awless
    aws-vault
    awscli2
    calicoctl
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
    httpie
    hugo
    imagemagick
    jwt-cli
    kubebuilder
    lefthook
    packer
    parallel
    pipenv
    protonup-ng
    python311
    sd
    shfmt
    sops
    tfenv
    trivy
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
