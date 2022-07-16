{ lib, pkgs, persistence, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_18;
    goPath = "go";
    goBin = "go/bin";
  };

  home.persistence = lib.mkIf persistence {
    "/persist/home/brenix".directories = [ "go" ];
  };
}
