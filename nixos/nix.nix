{ config, inputs, lib, pkgs, ... }:
{
  sops.secrets.nixAccessTokens = {
    mode = "0440";
    sopsFile = ./secrets.yaml;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      substituters = [
        "http://nix-cache.lan"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = [ "root" "@wheel" ];
      allowed-users = [ "root" "@wheel" ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
      flake-registry = ""; # Disable global flake registry

      # Allows building v3/v4 packages
      system-features = [ "gccarch-x86-64-v3" "gccarch-x86-64-v4" "big-parallel" ];
    };

    extraOptions = ''
      !include ${config.sops.secrets.nixAccessTokens.path}
    '';

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };
}
