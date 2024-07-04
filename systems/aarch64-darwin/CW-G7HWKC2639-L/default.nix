{pkgs, ...}: {
  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  programs.fish.enable = true;
  environment.shells = [pkgs.fish];

  services.nix-daemon.enable = true;

  matrix = {
    programs = {
      graphical = {
        addons.easy-move-plus-resize.enable = true;
        emulators.iterm2.enable = true;
        apps.mindnode.enable = true;
      };

      terminal = {
        tools = {
          mtr.enable = true;
        };
      };
    };

    services = {
      netskopeBundler.enable = true;
    };

    system = {
      # input.enable = true;
      fonts.enable = true;
      # interface.enable = true;
      security.enable = true;
    };
  };

  system.stateVersion = 4;
}
