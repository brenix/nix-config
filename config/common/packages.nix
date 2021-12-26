{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    bash-completion
    bat
    curlie
    delta
    dig
    fd
    gcc
    git
    glances
    gnumake
    gnupg
    lsof
    nmap
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
