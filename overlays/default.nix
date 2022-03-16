{ inputs }:

final: prev: {
  calicoctl = prev.callPackage ./calicoctl { };
}
