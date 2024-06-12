{
  pkgs,
  lib,
  ...
}: {
  cli.programs.git = {
    allowedSigners = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F";
    email = "pnicholson@coreweave.com";
  };

  cli.programs.python.enable = true;

  roles = {
    common.enable = true;
    work.enable = true;
  };

  home.packages = [
    pkgs.nh
  ];

  programs.fish.shellInit = lib.mkForce '''';

  matrix.user = {
    enable = true;
    name = "pnicholson";
  };

  home.stateVersion = "23.11";
}
