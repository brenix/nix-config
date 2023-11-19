{ pkgs ? import <nixpkgs> { } }: {
  awless = pkgs.callPackage ./awless { };
  awscli2 = pkgs.callPackage ./awscli2 { }; # FIXME: remove once fixed upstream: https://github.com/NixOS/nixpkgs/pull/267878
  calicoctl = pkgs.callPackage ./calicoctl { };
  monaco = pkgs.callPackage ./monaco { };
  tfenv = pkgs.callPackage ./tfenv { };
  tfsort = pkgs.callPackage ./tfsort { };
  wootility-lekker = pkgs.callPackage ./wootility-lekker { };
}
