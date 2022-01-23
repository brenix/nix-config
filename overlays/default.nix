{ inputs }:

final: prev: {

  # Install calicoctl
  calicoctl = final.callPackage ../pkgs/calicoctl.nix { };

  # Upgrade v4l-utils until merged upstream
  # v4l-utils = prev.v4l-utils.overrideAttrs (oldAttrs: rec {
  # version = "1.22.1";
  # pname = oldAttrs.pname;
  # src = prev.fetchurl {
  # url =
  # "https://linuxtv.org/downloads/${pname}/${pname}-${version}.tar.bz2";
  # sha256 = "sha256-Zcb76DCkTKEFxEOwJxgsGyyQU6kdHnKthJ36s4i5TjE=";
  # };
  # });

  # Use more recent version of nvim-treesitter plugin
  nvim-treesitter = prev.nvim-treesitter.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      rev = "bb33aea03cd65e62e0b5cdd0b1077c09b88dce1b";
      sha256 = "UcuZZNJmWSVfeLAUJ3q+NObDS/rGkXbBCdXcdMBBYXg=";
    };
  });

}
