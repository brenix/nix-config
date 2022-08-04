{ config, pkgs, inputs, lib, ... }:
let
  inherit (lib) mapAttrs' nameValuePair;
  toRegistry = mapAttrs' (n: v: nameValuePair n { flake = v; });
in
{
  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = [ "@wheel" ];
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
    };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
    gc = {
      automatic = true;
      dates = "weekly";
    };
    # Map flake inputs to system registries
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Map registries to channels
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
