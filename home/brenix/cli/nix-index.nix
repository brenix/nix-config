{ lib, persistence, ... }: {
  programs.nix-index.enable = true;

  #home.persistence = lib.mkIf persistence {
  #  "/persist/home/brenix".directories = [ ".cache/nix-index" ];
  #};
}
