{
  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  programs.fish.enable = true;
  services.nix-daemon.enable = true;

  matrix = {
    services.netskopeBundler.enable = true;
    system = {
      input.enable = true;
      fonts.enable = true;
      interface.enable = true;
    };
  };

  system.stateVersion = 4;
}
