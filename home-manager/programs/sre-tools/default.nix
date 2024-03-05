{ pkgs, ... }:
{
  imports = [
    ./terraform.nix
  ];

  home.packages = with pkgs; [
    apko
    awscli2
    certigo
    chamber
    glab
    gomplate
    graphviz
    jwt-cli
    markdownlint-cli
    openssl
    packer
    parallel
    postgresql
    shfmt
    vault-bin
    velero
    vendir
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/infractl"
        ".vdp"
      ];
      allowOther = true;
    };
  };
}
