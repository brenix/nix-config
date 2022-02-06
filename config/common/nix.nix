{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixUnstable;

    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;

    settings = {
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      auto-optimise-store = true;

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
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
