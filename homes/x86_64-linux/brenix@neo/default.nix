{
  cli.programs.git = {
    allowedSigners = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F";
  };

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

  nixicle.user = {
    enable = true;
    name = "brenix";
  };

  home.stateVersion = "23.11";
}
