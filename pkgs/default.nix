{ pkgs ? null }: {
  calicoctl = pkgs.callPackage ./calicoctl { };
  awless = pkgs.callPackage ./awless { };
  tfenv = pkgs.callPackage ./tfenv { };
  packer = pkgs.callPackage (import ./hashicorp/generic.nix) {
    name = "packer";
    version = "1.8.4";
    sha256 = "sha256-uiW4TMTTVB6aHcwLjhx8aT8bOaXRKRSRlOtrYFCuVsM=";
  };
}
