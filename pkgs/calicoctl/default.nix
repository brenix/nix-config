{ stdenv, fetchurl, lib }:

let
  version = "3.25.1";
in
stdenv.mkDerivation {
  pname = "calicoctl";
  inherit version;

  src = fetchurl {
    url = "https://github.com/projectcalico/calico/releases/download/v${version}/calicoctl-linux-amd64";
    sha256 = "sha256-E1ZeUwQgn/qpPfO6ci5vYjtmx2BXyo/1xYZPoTF2/kg=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/calicoctl
    chmod +x $out/bin/calicoctl
  '';
}
