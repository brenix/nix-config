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
          python.enable = true;
        };
      };

      graphical = {
        apps = {
          discord.enable = false;
          spotify.enable = true;
        };

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
