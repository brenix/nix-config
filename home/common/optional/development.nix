{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_21;
    goPath = ".cache/go";
    goBin = ".cache/go/bin";
  };

  home.packages = with pkgs; [
    go-tools
    golangci-lint
    gopls
    goreleaser
    gotools
    reftools
    lefthook
    pipenv
    python3
    yamlfmt
  ];
}
