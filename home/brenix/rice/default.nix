{ pkgs, config, inputs, wallpaper, colorscheme, ... }:

let
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) schemeFromYAML colorschemeFromPicture nixWallpaperFromScheme;
  inherit (builtins) pathExists readFile;
in
{
  imports = [ inputs.nix-colors.homeManagerModule ];

  colorscheme =
    if colorscheme != null then
      if pathExists (./colorschemes + "/${colorscheme}.yaml") then
        schemeFromYAML colorscheme (readFile (./colorschemes + "/${colorscheme}.yaml"))
      else
        inputs.nix-colors.colorSchemes.${colorscheme}
    else
      if wallpaper != null then
        colorschemeFromPicture
          {
            path = config.wallpaper;
            kind = "dark";
          }
      else inputs.nix-colors.colorSchemes.nord;

  wallpaper =
    if wallpaper != null then
      pkgs.wallpapers.${wallpaper}
    else
      nixWallpaperFromScheme {
        scheme = config.colorscheme;
        width = 2560;
        height = 1440;
        logoScale = 4.5;
      };
}
