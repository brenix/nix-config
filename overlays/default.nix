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

    # Downgrade zoom until it it is fixed upstream
    zoom-us = prev.zoom-us.overrideAttrs
      (oldAttrs: rec {
        version = "5.13.4.711";
        src = prev.fetchurl {
          url = "https://zoom.us/client/${version}/zoom_x86_64.pkg.tar.xz";
          hash = "sha256-sQk5fS/bS7e0T0IJ7+UB956XmCAbeMYfS8BVwncpoy0=";
        };
      });

    kitty = prev.kitty.overrideAttrs (oldAttrs: rec {
      doCheck = false;
      doInstallCheck = false;
    });

    # Additional vim plugins
    vimPlugins = prev.vimPlugins // { } // final.callPackage ../pkgs/vim-plugins { };

    # Build waybar with experimental flag set
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });

  };
}
