{ config, pkgs, ... }: {
  imports = [
    ../../modules/settings.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # -- ENVIRONMENT

  # XDG user dirs
  xdg.userDirs = {
    enable = true;
    documents = "$HOME/downloads/documents/";
    download = "$HOME/downloads/";
    videos = "$HOME/downloads/videos/";
    music = "$HOME/downloads/music/";
    pictures = "$HOME/downloads/pictures/";
    desktop = "$HOME/downloads/desktop/";
    publicShare = "$HOME/downloads/public/";
    templates = "$HOME/downloads/templates/";
  };

  # -- APPLICATIONS

  # Alacritty

  # Autocutsel
  systemd.user.services.autocutsel = {
    Unit.Description = "AutoCutSel";
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "forking";
      Restart = "always";
      RestartSec = 2;
      ExecStartPre = "${pkgs.autocutsel}/bin/autocutsel -fork";
      ExecStart = "${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork";
    };
  };

  # BSPWM
  # Bash
  # Firefox
  programs.firefox = {
    enable = true;
  };

  # Git
  programs.git = {
    enable = true;
    userName = config.settings.name;
    userEmail = config.settings.email;
    extraConfig = {
      init = { defaultBranch = "main"; };
    };
  };

  # GPG
  programs.gpg = {
    enable = true;
  };

  # NVIM
  # Openbox
  # Polybar
  # Rofi
  # SSH
  # Starship

  # TMUX
  programs.tmux = {
    enable = true;
    prefix = "C-x";
    terminal = "tmux-256color";
    escapeTime = 0;
  };

  # Terraform
  # ZSH
}
