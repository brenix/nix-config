{ inputs, lib, pkgs, config, outputs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) colorschemeFromPicture nixWallpaperFromScheme;
  inherit (builtins) pathExists readFile;
in
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nix-colors.homeManagerModule
    ../features/cli
    ../features/nvim
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  colorscheme = lib.mkDefault colorSchemes.nord;

  wallpaper = lib.mkDefault (nixWallpaperFromScheme {
    scheme = config.colorscheme;
    width = 2560;
    height = 1440;
    logoScale = 4.5;
  });

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
    stateVersion = lib.mkDefault "22.05";

    persistence = {
      "/persist/home/brenix" = {
        directories = [
          ".aws"
          ".awsvault"
          ".config/helm"
          ".config/infractl"
          ".config/sops"
          ".krew"
          ".kube"
          ".local/tfenv"
          ".local/bin"
          ".local/share/direnv"
          ".local/share/helm"
          ".local/state"
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
}