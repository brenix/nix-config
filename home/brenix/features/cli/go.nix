{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_19;
    goPath = ".cache/go";
    goBin = ".cache/go/bin";
  };
}
