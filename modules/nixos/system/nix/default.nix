{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.system.nix;
in {
  options.${namespace}.system.nix = {
    enable = mkBoolOpt false "Whether or not to manage nix configuration";
    package = mkOpt types.package pkgs.lix "Which nix package to use";
  };

  config = mkIf cfg.enable {
    sops.secrets.nixAccessTokens = {
      mode = "0440";
      sopsFile = ../../secrets.yaml;
    };

    # NOTE: allows 'sudo nixos-rebuild' to fetch private repos
    sops.secrets.sshKey = {
      mode = "0400";
      sopsFile = ../../secrets.yaml;
      path = "/root/.ssh/id_ed25519";
    };

    nix = {
      package = cfg.package;
      settings = {
        trusted-users = ["root" "@wheel"];
        auto-optimise-store = lib.mkDefault true;
        use-xdg-base-directories = true;
        connect-timeout = 5; # bail early on missing cache hits
        experimental-features = ["cgroups" "nix-command" "flakes"];
        keep-going = true;
        use-cgroups = true;
        warn-dirty = false;
        system-features = [
          "gccarch-x86-64-v3" # chaotic-nyx v3
          "gccarch-x86-64-v4" # chaotic-nyx v4
          "kvm"
          "big-parallel"
          "nixos-test"
        ];
        substituters = [
          "http://nix-cache.lan"
          "https://nyx.chaotic.cx"
          # "https://hyprland.cachix.org"
          # "https://nix-community.cachix.org"
          # "https://nixpkgs-wayland.cachix.org"
        ];
        trusted-public-keys = [
          "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8"
          # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          # "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        ];
      };
      extraOptions = ''
        !include ${config.sops.secrets.nixAccessTokens.path}
      '';

      # gc = {
      #   automatic = true;
      #   dates = "daily";
      #   options = "--delete-older-than 2d";
      # };

      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}
