{ pkgs ? import <nixpkgs> { } }: {
  awless = pkgs.callPackage ./awless { };
  calicoctl = pkgs.callPackage ./calicoctl { };
  monaco = pkgs.callPackage ./monaco { };
  # TODO: Add updated version of terraform-ls until merged upstream
  terraform-ls = pkgs.callPackage ./terraform-ls { };
  tfenv = pkgs.callPackage ./tfenv { };
  tfsort = pkgs.callPackage ./tfsort { };
  wootility-lekker = pkgs.callPackage ./wootility-lekker { };
}
