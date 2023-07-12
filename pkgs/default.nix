{ pkgs ? import <nixpkgs> { } }: {
  awless = pkgs.callPackage ./awless { };
  bpftune = pkgs.callPackage ./bpftune { }; # TODO: Remove once merged upstream
  calicoctl = pkgs.callPackage ./calicoctl { };
  monaco = pkgs.callPackage ./monaco { };
  tfenv = pkgs.callPackage ./tfenv { };
  tfsort = pkgs.callPackage ./tfsort { };
  wootility-lekker = pkgs.callPackage ./wootility-lekker { };
}
