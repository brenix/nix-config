{
  cli.programs.git = {
    allowedSigners = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F";
    email = "pnicholson@coreweave.com";
  };

  roles = {
    common.enable = true;
    work.enable = true;
  };

  matrix.user = {
    enable = true;
    name = "pnicholson";
  };

  home.stateVersion = "23.11";
}
