{ inputs, ... }: final: prev:
{
  # example = prev.example.overrideAttrs (oldAttrs: rec {
  # ...
  # });

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

  # Add our custom packages into the overlay
} // import ../pkgs { pkgs = prev; }
