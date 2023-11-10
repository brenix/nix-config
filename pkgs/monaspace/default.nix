{ lib, stdenv, fetchzip }:

stdenv.mkDerivation rec {
  pname = "monaspace";
  version = "1.000";

  src = fetchzip {
    url = "https://github.com/githubnext/monaspace/releases/download/v${version}/monaspace-v${version}.zip";
    hash = "sha256-H8NOS+pVkrY9DofuJhPR2OlzkF4fMdmP2zfDBfrk83A=";
    stripRoot = false;
  };

  installPhase = ''
    find . -name '*.otf' -exec install -m444 -Dt $out/share/fonts/opentype {} \;
  '';

  meta = with lib; {
    description = "Monaspace";
    longDescription = "An innovative superfamily of fonts for code.";
    homepage = "https://monaspace.githubnext.com/";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
