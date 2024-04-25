{
  profiles = {
    desktop.enable = true;
  };

  programs = {
    cli.go.enable = true;
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
