{ pkgs }: {
  comment-box-nvim = pkgs.callPackage ./comment-box-nvim { };
  nvim-femaco = pkgs.callPackage ./nvim-femaco { };
}
