{
  home.persistence = {
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
}
