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
    ./man-pages.nix
    ./nix-index.nix
    ./nix.nix
    ./nvim
    ./services.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./xresources.nix
    ./zsh
  ];

  home.packages = with pkgs; [
    age
    comma
    go-task
    gojq
    grc
    htop
    hugo
    imagemagick
    sd
    shfmt
    sops
    unrar
    unzip
    wireguard-tools
    yq-go
    zoxide
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".local/bin"
        ".local/state/wireplumber"
        ".local/share/zoxide"
        "Downloads"
        "nix-config"
        "work"
      ];
      allowOther = true;
    };
  };

}
