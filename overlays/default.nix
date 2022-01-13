{ inputs }:

final: prev: {

  # Install calicoctl
  calicoctl = final.callPackage ../pkgs/calicoctl.nix { };

  # Upgrade v4l-utils until merged upstream
  v4l-utils = prev.v4l-utils.overrideAttrs (oldAttrs: rec {
    version = "1.22.1";
    pname = oldAttrs.pname;
    src = prev.fetchurl {
      url =
        "https://linuxtv.org/downloads/${pname}/${pname}-${version}.tar.bz2";
      sha256 = "sha256-Zcb76DCkTKEFxEOwJxgsGyyQU6kdHnKthJ36s4i5TjE=";
    };
  });

}
