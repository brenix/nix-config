{ config, pkgs, ... }: {
  imports = [
    ../../modules/settings.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # -- ENVIRONMENT

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    LC_CTYPE = "en_US.UTF-8";
    BROWSER = config.settings.browser;
    TERM = config.settings.terminal;
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
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[▶](bold green)";
        error_symbol = "[▶](bold red)";
      };
      aws = {
        disabled = false;
        format = "[$profile(\$region\))]($style) ";
      };
      directory = {
        disabled = false;
        style = "blue";
      };
      hostname = {
        disabled = false;
        ssh_only = true;
        format = "[$hostname]($style) ";
      };
      terraform = {
        disabled = false;
        format = "";
      };
      git_branch = {
        disabled = false;
        format = "[\\(](white)[$branch](cyan)[\\)](white) ";
      };
      python = {
        disabled = false;
        format = "[(\($virtualenv\))]($style) ";
      };

      cmd_duration.disabled = true;
      golang.disabled = true;
      helm.disabled = true;
      kubernetes.disabled = true;
      line_break.disabled = true;
      lua.disabled = true;
      username.disabled = true;
    };
  };

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
