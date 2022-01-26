{ inputs }:

final: prev: {

  # Install calicoctl
  calicoctl = final.callPackage ../pkgs/calicoctl.nix { };

}
