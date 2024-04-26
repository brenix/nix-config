{
  matrix.user = {
    enable = true;
    name = "pnicholson";
  };

  roles = {
    common.enable = true;
  };

  programs = {
    cli.go.enable = true;
  };

  home.sessionPath = [
    "$HOME/bin"
  ];

  home.stateVersion = "23.11";
}
