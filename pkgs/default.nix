{ pkgs ? null }: {
  aiac = pkgs.callPackage ./aiac { };
  awless = pkgs.callPackage ./awless { };
  calicoctl = pkgs.callPackage ./calicoctl { };
  helmfile = pkgs.callPackage ./helmfile { };
  packer = pkgs.callPackage (import ./hashicorp/generic.nix) {
    name = "packer";
    version = "1.8.4";
    sha256 = "sha256-uiW4TMTTVB6aHcwLjhx8aT8bOaXRKRSRlOtrYFCuVsM=";
  };
  tfenv = pkgs.callPackage ./tfenv { };
}
