{ inputs, ... }: final: prev:
{
  # example = prev.example.overrideAttrs (oldAttrs: rec {
  # ...
  # });

  # Build waybar with experimental flag set
  waybar = prev.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

  # Add custom patch for pfetch
  pfetch = prev.pfetch.overrideAttrs (oldAttrs: {
    version = "unstable-2021-12-10";
    src = prev.fetchFromGitHub {
      owner = "dylanaraps";
      repo = "pfetch";
      rev = "a906ff89680c78cec9785f3ff49ca8b272a0f96b";
      sha256 = "sha256-9n5w93PnSxF53V12iRqLyj0hCrJ3jRibkw8VK3tFDvo=";
    };
    # Add term option, rename de to desktop, add scheme option
    patches = (oldAttrs.patches or [ ]) ++ [ ./pfetch.patch ];
  });

  # TODO: Remove once https://github.com/NixOS/nixpkgs/pull/187758 merged upstream
  piper = prev.callPackage ./piper { };

  # Add our custom packages into the overlay
} // import ../pkgs { pkgs = prev; }
