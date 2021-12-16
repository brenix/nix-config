{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    bash-completion
    bat
    curlie
    delta
    dconf
    dig
    fd
    gcc
    git
    glances
    gnumake
    gnupg
    lsof
    nmap
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

}
