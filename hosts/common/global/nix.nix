{ config, pkgs, inputs, lib, ... }:
{
  sops.secrets.nixAccessTokens = {
    mode = "0440";
    sopsFile = ../secrets.yaml;
  };

  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://nyx.chaotic.cx"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];

      trusted-users = [ "@wheel" ];
      allowed-users = [ "@wheel" ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
    extraOptions = ''
      !include ${config.sops.secrets.nixAccessTokens.path}
    '';
    package = lib.mkDefault pkgs.nix;
    gc = {
      automatic = true;
      dates = "daily";
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Map registries to channels
    # Very useful when using legacy commands
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
