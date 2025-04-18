{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.nix;
in {
  options.${namespace}.system.nix = {
    enable = mkBoolOpt false "Whether or not to manage nix configuration";
  };

  config = mkIf cfg.enable {
    systemd.user.startServices = "sd-switch";

    programs = {
      home-manager.enable = true;
    };

    home.sessionVariables = {
      FLAKE = "/home/${config.${namespace}.user.name}/nix-config";
    };

    nix = {
      settings = {
        trusted-substituters = [
          "http://nix-cache.home.arpa"
          "https://cache.nixos.org"
          # "https://nix-community.cachix.org"
          # "https://numtide.cachix.org?priority=42"
          # "https://ghostty.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          # "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
          # "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        ];

        experimental-features = ["nix-command" "flakes"];
        warn-dirty = false;
        use-xdg-base-directories = true;

        netrc-file = "/home/${config.${namespace}.user.name}/.netrc";
      };
    };

    news = {
      display = "silent";
      json = lib.mkForce {};
      entries = lib.mkForce [];
    };
  };
}
