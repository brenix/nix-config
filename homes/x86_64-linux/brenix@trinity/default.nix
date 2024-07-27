{pkgs, ...}: {
  matrix = {
    roles = {
      common.enable = true;
    };

    user = {
      enable = true;
      name = "brenix";
    };
  };

  home.packages = with pkgs; [
    fluxcd
  ];

  home.stateVersion = "23.11";
}
