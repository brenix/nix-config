{ stdenv
, fetchurl
, lib
}:
let
  name = "kubesess";
  version = "1.2.0";
in
stdenv.mkDerivation {
  pname = "kubesess";
  inherit version;

  src = fetchurl {
    url = "https://github.com/Ramilito/${name}/releases/download/${version}/${name}_${version}_x86_64-unknown-linux-musl.tar.gz";
    sha256 = "sha256-s0XhrfZahAeB+5ZqRybo2ELthuVXd8yG6RTPF42Imeg=";
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    mv ${name} $out/bin/${name}
  '';
}
