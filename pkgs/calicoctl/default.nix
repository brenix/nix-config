{ stdenv, fetchurl, lib }:

let
  version = "3.24.5";
in
stdenv.mkDerivation {
  pname = "calicoctl";
  inherit version;

  src = fetchurl {
    url = "https://github.com/projectcalico/calico/releases/download/v${version}/calicoctl-linux-amd64";
    sha256 = "sha256-AebIojcQUPnt0K3p3N6J2gVOhNjpa9S6jPgoBsjT6Oc=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/calicoctl
    chmod +x $out/bin/calicoctl
  '';
}
