{ inputs }:

final: prev: {

  # Install calicoctl
  calicoctl = final.callPackage ../pkgs/calicoctl.nix { };

  # Use more recent version of nvim-treesitter plugin
  nvim-treesitter = prev.nvim-treesitter.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      rev = "bb33aea03cd65e62e0b5cdd0b1077c09b88dce1b";
      sha256 = "UcuZZNJmWSVfeLAUJ3q+NObDS/rGkXbBCdXcdMBBYXg=";
    };
  });

}
