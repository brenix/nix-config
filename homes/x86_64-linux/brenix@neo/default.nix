{pkgs, ...}: {
  matrix = {
    user = {
      enable = true;
      name = "brenix";
    };

    roles = {
      desktop.enable = true;
    };

    programs = {
      terminal = {
        tools = {
          go.enable = true;
        };
      };

      graphical = {
        apps = {
          discord.enable = true;
          spotify.enable = true;
        };

        # editors.vscode = {
        #   enable = true;
        #   declarativeConfig = false;
        # };

        wms.hyprland.enable = true;
      };
    };

    services.mpd = {
      enable = true;
      musicDirectory = "/home/brenix/.local/share/mpd/music";
    };
  };

  home.packages = with pkgs; [
    talosctl
    talhelper
  ];

  home.stateVersion = "23.11";
}
