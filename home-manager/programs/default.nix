{ pkgs, ... }: {
  imports = [
    ./bat.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./nix-index.nix
    ./rbw.nix
    ./ssh.nix
    ./starship.nix
    ./zoxide.nix
  ];

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    (pkgs.uutils-coreutils.override { prefix = ""; })
    age
    calc
    comma
    curlie
    delta
    dogdns
    fd
    go-task
    gping
    htop
    hugo
    imagemagick
    jq
    ripgrep
    sd
    shfmt
    unrar
    unzip
    wireguard-tools
    xcp
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
