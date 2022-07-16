{ pkgs }: {
  # -- Wallpaper collection
  wallpapers = pkgs.callPackage ./wallpapers { };

  # -- Packages with an upstream source
  calicoctl = pkgs.callPackage ./calicoctl { };

  packer = pkgs.callPackage (import ./hashicorp/generic.nix) {
    name = "packer";
    version = "1.8.2";
    sha256 = "sha256-Z1vYJWGi5J+JdH4JIUHHznnC4qkQXmouvUmibfhJpGg=";
  };

  terraform = pkgs.callPackage (import ./hashicorp/generic.nix) {
    name = "terraform";
    version = "1.2.4";
    sha256 = "sha256-cF6mKkSgCBWU2taysJPu/vsS1U+logpmVi+eCCsAQUw=";
  };
}
