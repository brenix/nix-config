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

    # Additional vim plugins
    vimPlugins = prev.vimPlugins // {
      nvim-treesitter = prev.vimPlugins.nvim-treesitter.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [
          ./nvim-treesitter-nix-injection.patch
        ];
      });
    } // final.callPackage ../pkgs/vim-plugins { };

    # Build waybar with experimental flag set
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });

  };
}
