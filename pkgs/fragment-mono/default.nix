{ lib, fetchzip }:

let
  version = "1.003";
in
fetchzip rec {

  name = "fragment-mono";
  url = "https://github.com/weiweihuanghuang/fragment-mono/releases/download/${version}/fragment-mono-fonts.zip";
  sha256 = "sha256-id2ABkArl/lkvxcA49EbZ6XcQPl2hmwRnYz48oGrRA8=";

  postFetch = ''
    downloadedFile="/build/fragment-mono-fonts.zip"
    mkdir -p $out/share/fonts
    unzip -o -j $downloadedFile \*.ttf -d $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "Monospaced coding version of Helvetica";
    homepage = "https://github.com/weiweihuanghuang/fragment-mono";
    platforms = platforms.all;
  };
}
