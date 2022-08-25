{ inputs, lib, username, persistence, features, ... }:
{
  imports = [
    ./cli
    ./rice
    inputs.impermanence.nixosModules.home-manager.impermanence
  ]
  # Import features that have modules
  ++ builtins.filter builtins.pathExists (map (feature: ./${feature}) features);

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
    persistence = lib.mkIf persistence {
      "/persist/home/brenix".directories = [
        ".asdf"
        ".aws"
        ".awsvault"
        ".config/helm"
        ".config/infractl"
        ".config/sops"
        ".krew"
        ".kube"
        ".local/bin"
        ".local/share/direnv"
        ".local/share/helm"
        ".local/state"
        "Downloads"
        "nix-config"
        "work"
      ];
      "/persist/home/brenix".files = [
        ".gitconfig" # local work configuration (not managed by home-manager)
      ];
      "/persist/home/brenix".allowOther = true;
    };
  };
}
