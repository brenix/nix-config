{ pkgs, ... }:
{
  # Replace freetype with patched lcdfilter - causes impure evaluation
  system.replaceRuntimeDependencies = with pkgs; [{
    original = freetype;
    replacement = pkgs.lib.overrideDerivation freetype (oldAttrs: {
      patches = oldAttrs.patches ++ [
        (fetchurl {
          url = "https://gist.githubusercontent.com/brenix/bf63a85755391a52b8c885d0bf77fb10/raw/a9914cb653efce1e6ce2c0b7cb288c97de547cfc/freetype2-cleartype.patch";
          sha256 = "151lwwjjbkndf28l19849md6gzaxrbmjgcxgj8h7mryk0b78zsdv";
        })
      ];
    });
  }];
}
