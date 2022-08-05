{ lib, fetchzip }:

let
  version = "unstable-2022-08-04";
  repo = "SFMono-Nerd-Font-Ligaturized";
  rev = "83d887c6ec4989897fff19131a5de84766ecfdc9";
in
fetchzip rec {

  name = "sfmono-nerd-font-ligaturized-${version}";
  url = "https://github.com/shaunsingh/${repo}/archive/${rev}/${name}.zip";
  sha256 = "sha256-SHMkppOkmHA0X2am/1XBt0XE6ctrYyjkT6b/QZHrhZI=";

  postFetch = ''
    downloadedFile="/build/${name}.zip"
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile \*.otf -d $out/share/fonts/opentype
  '';

  meta = with lib; {
    description = "Apple's SFMono font nerd-font patched and ligaturized";
    homepage = "https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized";
    platforms = platforms.all;
  };
}
