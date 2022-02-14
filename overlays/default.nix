{ inputs }:

final: prev: {

  # Install calicoctl
  calicoctl = prev.callPackage ../pkgs/calicoctl.nix { };

  # Velero
  velero = prev.callPackage ./velero { };

}
