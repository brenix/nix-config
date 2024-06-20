{pkgs, ...}: {
  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  programs.fish.enable = true;
  environment.shells = [pkgs.fish];

  services.nix-daemon.enable = true;

  matrix = {
    apps = {
      easy-move-plus-resize.enable = true;
      iterm2.enable = true;
      mindnode.enable = true;
      mtr.enable = true;
      # vscode.enable = true;
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
