{ lib, pkgs, persistence, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_18;
    goPath = ".cache/go";
    goBin = ".cache/go/bin";
  };
}
