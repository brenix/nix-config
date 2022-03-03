{ inputs }:

final: prev: {

  # Install calicoctl
  calicoctl = prev.callPackage ../pkgs/calicoctl.nix { };

}
