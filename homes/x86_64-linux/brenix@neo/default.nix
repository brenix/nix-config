{
  roles = {
    desktop.enable = true;
  };

  cli.programs.go.enable = true;

  programs = {
    discord.enable = true;
    spotify.enable = true;
    vscode.enable = true;
  };

  desktops.hyprland.enable = true;

  matrix.user = {
    enable = true;
    name = "brenix";
  };

  home.stateVersion = "23.11";
}
