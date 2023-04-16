{ outputs, inputs }: {
  # Adds my custom packages
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # Modifies existing packages
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # kitty = prev.kitty.overrideAttrs (_: {
    #   doCheck = false;
    #   doInstallCheck = false;
    # });

    # qemu = prev.qemu.overrideAttrs (oldAttrs: {
    #   patches = (oldAttrs.patches or [ ]) ++ [ ./evdev-fix.patch ];
    # });

    # Additional vim plugins
    vimPlugins = prev.vimPlugins // { } // final.callPackage ../pkgs/vim-plugins { };
  };
}
