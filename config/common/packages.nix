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
    wireguard-tools
    zsh
    zsh-completions
  ];

  programs.mtr.enable = true;
  programs.dconf.enable = true;
}
