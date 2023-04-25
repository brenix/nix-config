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
    ./rbw.nix
    ./services.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./xdg.nix
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
    (writeShellScriptBin "jq" "exec -a $0 ${gojq}/bin/gojq $@")
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/sops"
        ".local/bin"
        ".local/state/wireplumber"
        ".local/share/zoxide"
        "nix-config"
        "work"
      ];
      allowOther = true;
    };
  };

}
