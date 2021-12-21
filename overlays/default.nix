{ inputs }:

final: prev: {
  calicoctl = prev.callPackage ../pkgs/calicoctl.nix { };
}
