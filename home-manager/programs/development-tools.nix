{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_22;
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
    # pipenv
    poetry
    python3
    yamlfmt
  ];
}
