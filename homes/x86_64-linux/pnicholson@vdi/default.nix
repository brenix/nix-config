{
  cli.programs.git.allowedSigners = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGH6D2sNMsbMo6DMdwuwDjPpRBM8ZDZtQa/FG4Ape5ei";

  profiles = {
    common.enable = true;
  };

  nixicle.user = {
    enable = true;
    name = "pnicholson";
  };

  home.stateVersion = "23.11";
}
