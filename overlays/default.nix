{
  # Adds my custom packages
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # My wallpapers
  wallpapers = final: prev: {
    wallpapers = final.callPackage ../pkgs/wallpapers { };
  };

  # Modifies existing packages
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    dwm = prev.dwm.overrideAttrs (oldattrs: {
      src = prev.fetchFromGitHub {
        owner = "brenix";
        repo = "dwm";
        rev = "30fc429abea0990da20ebf1f24b1670d476e427c";
        sha256 = "sha256-ybZFWye6QupOl8usYEeFY3GbDctXFUTDXCLn9UTNVMg=";
      };
    });

    # Additional vim plugins
    vimPlugins = prev.vimPlugins // { } // final.callPackage ../pkgs/vim-plugins { };

    # Build waybar with experimental flag set
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });

  };
}
