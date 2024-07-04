{
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
          yazi.enable = true;
        };
      };

      graphical = {
        apps = {
          discord.enable = true;
          spotify.enable = true;
        };

        editors.vscode = {
          enable = true;
          declarativeConfig = false;
        };

        wms.hyprland.enable = true;
      };
    };
  };

  home.stateVersion = "23.11";
}
