{ pkgs, inputs, lib, nix-colors, ... }: {

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ inputs.nur.overlay ];
  };

  nix = {
    package = pkgs.nixUnstable;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

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

    # This will add your inputs as registries, making operations with them
    # consistent with your flake inputs.
    registry = lib.mapAttrs'
      (n: v:
        lib.nameValuePair n { flake = v; }
      )
      inputs;
  };
}
