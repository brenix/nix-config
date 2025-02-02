{
  lib,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "berkeley-mono";
  version = "1.0";

  src = builtins.fetchGit {
    url = "git@github.com:brenix/berkeley-mono.git";
    ref = "main";
    rev = "6519428ea186d824a37cc36f5af226c1e498c335";
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r $src/TTF/* $out/share/fonts/
    cp -r $src/OTF/* $out/share/fonts/
  '';

  meta = with lib; {
    description = "Berkeley Mono Font";
    license = licenses.unfree;
  };
}
