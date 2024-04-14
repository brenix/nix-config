{ pkgs, ... }:
{
  imports = [
    ./terraform.nix
  ];

  home.packages = with pkgs; [
    # apko
    # atmos
    # awscli2
    bubblewrap
    certigo
    # chamber
    glab
    gomplate
    graphviz
    jwt-cli
    # melange
    packer
    # postgresql
    shfmt
    vault-bin
    # velero
    # vendir
  ];

  # home.persistence = {
  #   "/persist/home/brenix" = {
  #     directories = [
  #     ];
  #     allowOther = true;
  #   };
  # };
}
