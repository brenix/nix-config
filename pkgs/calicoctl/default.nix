{ stdenv, fetchurl, lib }:

let
  version = "3.23.3";
in
stdenv.mkDerivation {
  pname = "calicoctl";
  inherit version;

  src = fetchurl {
    url = "https://github.com/projectcalico/calico/releases/download/v${version}/calicoctl-linux-amd64";
    sha256 = "sha256-2cBKsVutnYA3GSq9KqRzOgGwtkpGHHt4gRig1nR8Fzc=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/calicoctl
    chmod +x $out/bin/calicoctl
  '';
}
