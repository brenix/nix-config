{ pkgs, ... }:
{
  # Replace freetype with patched lcdfilter - causes impure evaluation
  system.replaceRuntimeDependencies = with pkgs; [{
    original = freetype;
    replacement = pkgs.lib.overrideDerivation freetype (oldAttrs: {
      patches = oldAttrs.patches ++ [
        (fetchurl {
          url = "https://aur.archlinux.org/cgit/aur.git/plain/like-ultimate5.patch?h=freetype2-ultimate5";
          sha256 = "sha256-lVTTojYZpGz0jlEuW2M2r9CAL0L9r5suR7oMcYFD8d0=";
        })
        (fetchurl {
          url = "https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/freetype2/trunk/0003-Enable-infinality-subpixel-hinting.patch";
          sha256 = "sha256-yqC8fT36O0xrm+7NphQUBdr+VA+ZplXcg9FwT6IyrCA=";
        })
      ];
    });
  }];
}
