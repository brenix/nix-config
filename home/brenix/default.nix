{ inputs, lib, username, persistence, features, ... }:

let
  inherit (lib) optional mkIf;
  inherit (builtins) map pathExists filter;
in
{
  imports = [
    ./cli
    ./rice
    inputs.impermanence.nixosModules.home-manager.impermanence
  ]
  # Import features that have modules
  ++ filter pathExists (map (feature: ./${feature}) features);

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
    direnv.enable = true;
  };

  home = {
    inherit username;
    stateVersion = "22.05";
    homeDirectory = "/home/${username}";
    persistence = mkIf persistence {
      "/persist/home/brenix".directories = [
        ".asdf"
        ".aws"
        ".awsvault"
        ".config/helm"
        ".config/infractl"
        ".krew"
        ".kube"
        ".local/bin"
        ".local/share/containers"
        ".local/share/direnv"
        ".local/share/helm"
        "downloads"
        "nixos-config"
        "work"
      ];
      "/persist/home/brenix".files = [
        ".gitconfig" # local work configuration (not managed by home-manager)
      ];
      "/persist/home/brenix".allowOther = true;
    };
  };
}
