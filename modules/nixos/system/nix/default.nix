{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.system.nix;
in {
  options.system.nix = with types; {
    enable = mkBoolOpt false "Whether or not to manage nix configuration";
  };

  config = mkIf cfg.enable {
    sops.secrets.nixAccessTokens = {
      mode = "0440";
      sopsFile = ../../secrets.yaml;
    };

    nix = {
      settings = {
        trusted-users = ["root" "@wheel"];
        auto-optimise-store = lib.mkDefault true;
        use-xdg-base-directories = true;
        experimental-features = ["nix-command" "flakes" "repl-flake"];
        warn-dirty = false;
        system-features = [
          "gccarch-x86-64-v3" # chaotic-nyx v3
          "gccarch-x86-64-v4" # chaotic-nyx v4
          "kvm"
          "big-parallel"
          "nixos-test"
        ];
      };
      extraOptions = ''
        !include ${config.sops.secrets.nixAccessTokens.path}
      '';
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 2d";
      };
      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}