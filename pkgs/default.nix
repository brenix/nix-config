{ pkgs ? import <nixpkgs> { } }: {
  awless = pkgs.callPackage ./awless { };
  calicoctl = pkgs.callPackage ./calicoctl { };
  monaco = pkgs.callPackage ./monaco { };
  tfenv = pkgs.callPackage ./tfenv { };
  wootility-lekker = pkgs.callPackage ./wootility-lekker { };
}
