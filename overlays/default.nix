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
