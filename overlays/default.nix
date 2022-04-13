{ inputs }:

final: prev: {
  calicoctl = prev.callPackage ./calicoctl { };
  quake-champions = prev.callPackage ./quake-champions { };
}
