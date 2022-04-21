{ inputs }:

final: prev: {
  calicoctl = prev.callPackage ./calicoctl { };
  authy = prev.callPackage ./authy { };
}
