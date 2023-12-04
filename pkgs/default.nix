{ pkgs ? import <nixpkgs> { } }: {
  awless = pkgs.callPackage ./awless { };
  calicoctl = pkgs.callPackage ./calicoctl { };
  certmgr = pkgs.callPackage ./certmgr { }; # FIXME: remove once merged upstream: https://github.com/NixOS/nixpkgs/pull/268975
  monaco = pkgs.callPackage ./monaco { };
  tfenv = pkgs.callPackage ./tfenv { };
  tfsort = pkgs.callPackage ./tfsort { };
  wootility-lekker = pkgs.callPackage ./wootility-lekker { };
}
