{ pkgs, ... }:
{
  imports = [
    ./terraform.nix
  ];

  home.packages = with pkgs; [
    apko
    awscli2
    bubblewrap
    certigo
    chamber
    glab
    gomplate
    graphviz
    jwt-cli
    markdownlint-cli
    melange
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
