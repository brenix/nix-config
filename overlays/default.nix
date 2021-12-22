{ inputs }:

final: prev: {
  calicoctl = final.callPackage ../pkgs/calicoctl.nix { };
}
