{ config, pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    bash-completion
    bat
    curlie
    delta
    dconf
    dig
    fd
    fzf
    gcc
    git
    glances
    gnumake
    gnupg
    go
    htop
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

}
