{ inputs }:

final: prev: {

  # Install calicoctl
  calicoctl = prev.callPackage ./calicoctl { };

}
