{ pkgs, ... }: {
  imports = [
    ./atuin.nix
    ./bat.nix
    ./dircolors.nix
    ./epr.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./nix-index.nix
    ./rbw.nix
    ./ssh.nix
    ./starship.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    age
    comma
    curlie
    delta
    fd
    go-task
    htop
    hugo
    imagemagick
    jq
    libqalculate
    ripgrep
    sd
    shfmt
    unrar
    unzip
    wireguard-tools
    yq-go
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".local/bin"
        ".local/state/wireplumber"
        "nix-config"
      ];
      allowOther = true;
    };
  };
}
