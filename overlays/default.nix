# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # Patch libvirt until fixed upstream
    # https://github.com/NixOS/nixpkgs/issues/285929
    libvirt = prev.libvirt.overrideAttrs (oldAttrs: rec {
      postPatch = oldAttrs.postPatch + ''
        substituteInPlace src/util/virpci.c --replace '/lib/modules' '/run/current-system/kernel-modules/lib/modules'
      '';
    });
  };
}
