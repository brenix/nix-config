{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    bash-completion
    bat
    curlie
    delta
    dig
    fd
    gcc
    gettext
    git
    glances
    gnumake
    gnupg
    lsof
    nmap
    openssl
    pciutils
    ripgrep
    rsync
    tcpdump
    tmux
    wireguard
    zsh
    zsh-completions
  ];

  # Enable mtr and configure a setcap wrapper to run without sudo
  programs.mtr.enable = true;

  # Enable dconf (gtk dep)
  programs.dconf.enable = true;
}
