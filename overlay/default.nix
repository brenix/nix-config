{ inputs, ... }: final: prev:
{
  # example = prev.example.overrideAttrs (oldAttrs: rec {
  # ...
  # });

  # Build waybar with experimental flag set
  waybar = prev.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

  # Add our custom packages into the overlay
} // import ../pkgs { pkgs = prev; }
