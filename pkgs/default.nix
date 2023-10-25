{ pkgs ? import <nixpkgs> { } }: {
  awless = pkgs.callPackage ./awless { };
  calicoctl = pkgs.callPackage ./calicoctl { };
  monaco = pkgs.callPackage ./monaco { };
  helix = pkgs.callPackage ./helix { };
  tfenv = pkgs.callPackage ./tfenv { };
  tfsort = pkgs.callPackage ./tfsort { };
  wootility-lekker = pkgs.callPackage ./wootility-lekker { };
}
