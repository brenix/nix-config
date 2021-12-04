{ config, pkgs, ...}: {

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

}
