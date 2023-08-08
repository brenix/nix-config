{ pkgs, ... }:
{
  programs.go = {
    enable = true;
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
    python311
    yamlfmt
  ];
}
