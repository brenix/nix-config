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

  # TMUX
  programs.tmux = {
    enable = true;
    prefix = "C-x";
    terminal = "tmux-256color";
    escapeTime = 0;
    baseIndex = 1;
    extraConfig = ''
      set-option -g mouse on
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind n new-window -c "#{pane_current_path}"
      bind tab next-window
      bind t command-prompt "rename-window %%"
      bind , select-layout even-vertical
      bind . select-layout even-horizontal
      bind v setw synchronize-panes\; display "Sync panes is now #{?pane_synchronized,on,off}!"
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D
      bind up resize-pane -U 5
      bind down resize-pane -D 5
      bind left resize-pane -L 5
      bind right resize-pane -R 5
    '';
  };

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
