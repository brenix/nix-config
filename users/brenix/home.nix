{ config, pkgs, ... }: {
  imports = [
    ../../modules/settings.nix
    ./alacritty.nix
    ./dunst.nix
    ./firefox.nix
    ./git.nix
    ./starship.nix
    #./polybar.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # -- ENVIRONMENT

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    LC_CTYPE = "en_US.UTF-8";
    BROWSER = config.settings.browser;
  };

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

  # GPG
  programs.gpg = {
    enable = true;
  };

  # TODO: Autorandr
  # TODO: NVIM
  # TODO: Openbox
  # TODO: Polybar
  # TODO: Rofi
  # TODO: SSH
  # TODO: Terraform
  # TODO: ZSH

  # TMUX
  programs.tmux = {
    enable = true;
    prefix = "C-x";
    terminal = "tmux-256color";
    escapeTime = 0;
  };

  # -- SERVICES

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
}
