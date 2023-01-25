# when changing this expression convert it from 'fetchzip' to 'stdenvNoCC.mkDerivation'
{ lib, fetchzip }:

let
  version = "4c7fe33df56420b06e0a094db9c4d9a23333b1b7";
in
(fetchzip {
  name = "monaco-nerd-font-${version}";

  url = "https://github.com/Karmenzind/monaco-nerd-fonts/archive/${version}.zip";

  sha256 = "sha256-G1jZ96b/Bkz3qqbceCGKmJu4D1EY5kkgknA5soqQLb0=";

  meta = with lib; {
    description = "Terminal-friendly monaco font, with extra nerd glyphs, patched with ryanoasis's nerd patcher";
    homepage = "https://github.com/Karmenzind/monaco-nerd-fonts";
    maintainers = with maintainers; [ ];
  };
}).overrideAttrs (_: {
  postFetch = ''
    unzip -j $downloadedFile
    for i in *.ttf; do
      local destname="$(echo "$i" | sed -E 's|-[[:digit:].]+\.ttf$|.ttf|')"
      install -Dm 644 "$i" "$out/share/fonts/truetype/$destname"
    done
  '';
})
