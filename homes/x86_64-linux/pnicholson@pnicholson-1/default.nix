{
  lib,
  pkgs,
  ...
}: {
  matrix = {
    programs = {
      terminal = {
        tools = {
          git = {
            allowedSigners = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F";
            email = "pnicholson@coreweave.com";
          };

          python.enable = true;
          yazi.enable = true;
        };
      };
    };

    roles = {
      common.enable = true;
      work.enable = true;
    };

    user = {
      enable = true;
      name = "pnicholson";
    };
  };

  home.packages = [
    pkgs.nh
    pkgs.kubernetes
  ];

  programs.fish.shellInit = lib.mkForce '''';

  home.stateVersion = "23.11";
}
