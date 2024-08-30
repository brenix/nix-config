{
  lib,
  requireFile,
  stdenvNoCC,
  unzip,
  variant ? "ligaturesoff-0variant2-7variant0",
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "berkeley-mono";
  version = "1.009";

  src = requireFile rec {
    name = "${finalAttrs.pname}-${variant}-${finalAttrs.version}.zip";
    sha256 = "1jy95ngmp0sm11bra0il8sh19q2zy7qxnsz7ck36sj4a6k4k2c9q";
    message = ''
      This file needs to be manually downloaded from the Berkeley Graphics
      site (https://berkeleygraphics.com/accounts). An email will be sent to
      get a download link.

      Select the variant that matches “${variant}”
      & download the zip file.

      Then run:

      mv \$PWD/berkeley-mono-typeface.zip \$PWD/${name}
      nix-prefetch-url --type sha256 file://\$PWD/${name}
    '';
  };

  # outputs = ["out" "web" "variable" "variableweb"];
  outputs = ["out"];

  nativeBuildInputs = [
    unzip
  ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    runHook preInstall

    install -D -m444 -t $out/share/fonts/opentype berkeley-mono/OTF/*.otf
    install -D -m444 -t $out/share/fonts/truetype berkeley-mono/TTF/*.ttf
    # install -D -m444 -t $web/share/fonts/webfonts berkeley-mono/WEB/*.woff2
    # install -D -m444 -t $variable/share/fonts/truetype berkeley-mono-variable/TTF/*.ttf
    # install -D -m444 -t $variableweb/share/fonts/webfonts berkeley-mono-variable/WEB/*.woff2

    runHook postInstall
  '';

  meta = {
    description = "Berkeley Mono Typeface";
    homepage = "https://berkeleygraphics.com/typefaces/berkeley-mono";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all;
  };
})
