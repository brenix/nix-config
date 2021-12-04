{ pkgs, inputs, system, ... }: {

  imports = [
    ./home/alacritty.nix
    ./home/dunst.nix
    ./home/git.nix
    ./home/neovim.nix
    ./home/packages.nix
    ./home/polybar.nix
    ./home/starship.nix
    ./home/tmux.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    LC_CTYPE = "en_US.UTF-8";
  };

  # XDG
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
      size = 10;
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

  # GPG
  programs.gpg = {
    enable = true;
  };

  # rofi
  programs.rofi = {
    enable = true;
    font = "Terminus 10";
    theme = "paper-float";
  };


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


  # Flameshot
  services.flameshot.enable = true;
}
