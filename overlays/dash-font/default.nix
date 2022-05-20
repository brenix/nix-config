{ stdenv }:

stdenv.mkDerivation rec {
  name = "dash-font";
  version = "2016-09-17";

  src = ./dash.pcf;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/fonts/dash
    cp -r $src $out/share/fonts/dash
  '';
}
