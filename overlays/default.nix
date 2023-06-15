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

    # Custom xanmod kernel
    # xanmod =
    #   let
    #     version = "6.3.5";
    #     suffix = "xanmod1";
    #     hash = "sha256-2+8WDj1VdmIdC0DjmKyY/fMi5zoiXDAWy7EAmkImvXk=";
    #   in
    #   prev.linuxPackagesFor (prev.linux_xanmod_latest.override (_: {
    #     inherit version;
    #     inherit suffix;
    #     modDirVersion = prev.lib.versions.pad 3 "${version}-${suffix}";
    #     src = prev.fetchFromGitHub {
    #       owner = "xanmod";
    #       repo = "linux";
    #       rev = prev.lib.versions.pad 3 "${version}-${suffix}";
    #       inherit hash;
    #     };
    #   }));

    # Additional vim plugins
    vimPlugins = prev.vimPlugins // { } // final.callPackage ../pkgs/vim-plugins { };
  };
}
