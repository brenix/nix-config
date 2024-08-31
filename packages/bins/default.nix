{stdenv, ...}:
stdenv.mkDerivation {
  name = "bins";
  version = "unstable";
  src = ./bin;
  installPhase = ''
    mkdir -p $out/bin
    install -D -m 0755 * $out/bin
  '';
}
