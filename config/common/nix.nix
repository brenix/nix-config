{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;

    autoOptimiseStore = true;

    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "@wheel" ];

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      dates = "daily";
    };

    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # documentation.nixos.enable = false;

}
