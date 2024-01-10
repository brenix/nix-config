{ inputs, lib, pkgs, config, outputs, ... }:
{
  imports =
    [
      inputs.nix-colors.homeManagerModule
      inputs.nixvim.homeManagerModules.nixvim
      inputs.nur.hmModules.nur
      inputs.impermanence.nixosModules.home-manager.impermanence
      inputs.chaotic.homeManagerModules.default

      ./programs

      ./browsers/firefox.nix
      ./browsers/chromium.nix

      ./editors/helix

      ./multiplexers/tmux.nix

      ./desktops/bspwm.nix
      ./desktops/openbox.nix
      ./desktops/hyprland.nix
      ./desktops/common

      ./security/sops.nix

      ./shells/fish

      ./terminals/alacritty.nix
      ./terminals/foot.nix
    ]
    ++ builtins.attrValues outputs.homeManagerModules;

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
  };

  home.sessionVariables.EDITOR = config.my.settings.default.editor;

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      substituters = [
        "http://192.168.1.10"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
      netrc-file = "$HOME/.config/nix/netrc";
    };
  };
}
