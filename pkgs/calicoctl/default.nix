{ stdenv, fetchurl, lib }:

let
  version = "3.23.2";
in
stdenv.mkDerivation {
  pname = "calicoctl";
  inherit version;

  src = fetchurl {
    url = "https://github.com/projectcalico/calico/releases/download/v${version}/calicoctl-linux-amd64";
    sha256 = "sha256-N4QgDN/AEGyZh98gSNIZu5EUfwzD+jZbNieayC6jfHo=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/calicoctl
    chmod +x $out/bin/calicoctl
  '';
}
