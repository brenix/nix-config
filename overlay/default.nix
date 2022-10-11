{ inputs, ... }: final: prev:
{
  # example = prev.example.overrideAttrs (oldAttrs: rec {
  # ...
  # });

  # Update kustomize to latest until fixed upstream
  kustomize = prev.kustomize.overrideAttrs (oldAttrs: rec {
    version = "4.5.7";
  });

  # Build waybar with experimental flag set
  waybar = prev.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

  # Add our custom packages into the overlay
} // import ../pkgs { pkgs = prev; }
