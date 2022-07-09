{ inputs }:

final: prev: {
  calicoctl = prev.callPackage ./calicoctl { };
  packer = prev.callPackage (import ./hashicorp/generic.nix) {
    name = "packer";
    version = "1.8.2";
    sha256 = "sha256-Z1vYJWGi5J+JdH4JIUHHznnC4qkQXmouvUmibfhJpGg=";
  };
  terraform = prev.callPackage (import ./hashicorp/generic.nix) {
    name = "terraform";
    version = "1.2.4";
    sha256 = "sha256-cF6mKkSgCBWU2taysJPu/vsS1U+logpmVi+eCCsAQUw=";
  };
}
