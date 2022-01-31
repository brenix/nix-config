{ pkgs ? import <nixpkgs> { } }:

let version = "3.22.0";
in
pkgs.stdenv.mkDerivation rec {
  inherit version;

  name = "calicoctl";

  src = pkgs.fetchurl {
    url =
      "https://github.com/projectcalico/calico/releases/download/v${version}/calicoctl-linux-amd64";
    sha256 = "1jar2m8frzfmgs0dpf37cz8h8xyi041dkdfg93v1s1q8fcjzcf2i";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/calicoctl
    chmod +x $out/bin/calicoctl
  '';

}
