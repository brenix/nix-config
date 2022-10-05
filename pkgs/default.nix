{ pkgs }: {
  # -- Wallpaper collection
  wallpapers = pkgs.callPackage ./wallpapers { };

  # -- Packages with an upstream source
  calicoctl = pkgs.callPackage ./calicoctl { };
  awless = pkgs.callPackage ./awless { };
  fragment-mono = pkgs.callPackage ./fragment-mono { };

  # -- Hashicorp packages
  packer = pkgs.callPackage (import ./hashicorp/generic.nix) {
    name = "packer";
    version = "1.8.3";
    sha256 = "sha256-BYf3gV7XlYnNnCt1TIIRVzHI0Lj9O3Rv5ABV2Wn6y6U=";
  };

  terraform = pkgs.callPackage (import ./hashicorp/generic.nix) {
    name = "terraform";
    version = "1.2.6";
    sha256 = "sha256-n9RF56GRMX3PyZ0BKrYy8swB8SrxSkTfurqC4PloA2U=";
  };
}
