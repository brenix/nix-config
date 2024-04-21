{
  # cli.programs.git.allowedSigners = "";

  profiles = {
    common.enable = true;
    development.enable = true;
  };

  nixicle.user = {
    enable = true;
    name = "pnicholson";
  };

  home.stateVersion = "23.11";
}
