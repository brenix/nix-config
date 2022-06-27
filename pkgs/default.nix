{ inputs }:

final: prev: {
  calicoctl = prev.callPackage ./calicoctl { };
  dash-font = prev.callPackage ./dash-font { };
  packer = prev.callPackage (import ./hashicorp/generic.nix) {
    name = "packer";
    version = "1.8.0";
    sha256 = "sha256-lMXWU4b6jxfjbTSW+73xjTv6sBMGqoAAwUZWtjBwt8I=";
  };
  terraform = prev.callPackage (import ./hashicorp/generic.nix) {
    name = "terraform";
    version = "1.2.3";
    sha256 = "sha256-cotvvLKIrRt7ZZBYVBCpjTt+Be/kYB73dsN+FemoOpY=";
  };
}
