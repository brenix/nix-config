{ config, pkgs, ... }: {
  imports = [
    ../../modules/settings.nix
    ./alacritty.nix
    ./dunst.nix
    ./firefox.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
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

  # GTK
  gtk = {
    enable = true;
    font = {
      package = pkgs.corefonts;
      name = "Verdana";
      size = 9;
    };
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc";
    };
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

  programs.rofi = {
    enable = true;
    font = "Terminus 10";
    theme = "paper-float";
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

  services.flameshot.enable = true;
}
