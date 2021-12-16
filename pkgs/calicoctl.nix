{ pkgs ? import <nixpkgs> { } }:

let
  version = "3.21.2";
in
pkgs.stdenv.mkDerivation rec {
  inherit version;

  name = "calicoctl";

  src = pkgs.fetchurl {
    url = "https://github.com/projectcalico/calicoctl/releases/download/v${version}/calicoctl-linux-amd64";
    sha256 = "1qxpfppqdpyj9mrcnszr3wm48pzg64m44wk8xw4g002f4pyfv5fl";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/calicoctl
    chmod +x $out/bin/calicoctl
  '';

}
