{ config, lib, pkgs, ... }:
{
  imports = [
    ./dunst.nix
    ./flameshot.nix
    ./gammastep.nix
    ./gtk.nix
    ./mako.nix
    ./picom.nix
    ./polybar
    ./rofi
    ./waybar.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; lib.mkIf (!config.my.settings.headless) [
    mpv
    mupdf
    nsxiv
    pavucontrol
    playerctl
    xdg-utils
  ];

  services.playerctld = {
    enable = lib.mkIf (!config.my.settings.headless) true;
  };

  # Create clipcat config
  xdg.configFile = lib.mkIf (!config.my.settings.headless) {
    "clipcat/clipcatd.toml".text = ''
      daemonize = false
      max_history = 50
      history_file_path = '/home/brenix/.cache/clipcat/clipcatd/db'
      log_level = 'INFO'

      [monitor]
      load_current = true
      enable_clipboard = true
      enable_primary = false

      [grpc]
      host = '127.0.0.1'
      port = 45045
    '';

    "clipcat/clipcatctl.toml".text = ''
      server_host = '127.0.0.1'
      server_port = 45045
      log_level = 'INFO'
    '';

    "clipcat/clipcat-menu.toml".text = ''
      server_host = '127.0.0.1'
      server_port = 45045
      finder = 'fzf'
    '';
  };
}
