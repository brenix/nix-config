{ pkgs }: {
  # -- Wallpaper collection
  wallpapers = pkgs.callPackage ./wallpapers { };

  # -- Packages with an upstream source
  calicoctl = pkgs.callPackage ./calicoctl { };
  awless = pkgs.callPackage ./awless { };
  tfenv = pkgs.callPackage ./tfenv { };

  # -- Hashicorp binary packages
  packer = pkgs.callPackage (import ./hashicorp/generic.nix) {
    name = "packer";
    version = "1.8.3";
    sha256 = "sha256-BYf3gV7XlYnNnCt1TIIRVzHI0Lj9O3Rv5ABV2Wn6y6U=";
  };
}
