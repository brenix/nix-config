{ inputs, lib, pkgs, config, outputs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nix-colors.homeManagerModule
    ../features/cli
    ../features/nvim
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  colorscheme = lib.mkDefault colorSchemes.nord;

  home.file.".colorscheme".text = config.colorscheme.slug;

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  home = {
    username = lib.mkDefault "brenix";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.11";
    sessionPath = [ "$HOME/.local/bin" ];

    persistence = {
      "/persist/home/brenix" = {
        directories = [
          ".aws"
          ".awsvault"
          ".config/infractl"
          ".config/sops"
          ".local/bin"
          ".local/state/wireplumber"
          ".local/tfenv"
          "Downloads"
          "nix-config"
          "work"
        ];
        files = [
          ".gitconfig" # local work configuration (not managed by home-manager)
        ];
        allowOther = true;
      };
    };
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

}
