{ pkgs, ... }: {
  imports = [
    ./bat.nix
    ./dircolors.nix
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
    # Disabled for now since Chaotic-nyx includes a x86_64_v3 optimized versions
    # (pkgs.uutils-coreutils.override { prefix = ""; })
    age
    comma
    curlie
    delta
    dogdns
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
