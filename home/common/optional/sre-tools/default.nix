{ pkgs, ... }:
{
  imports = [
    ./terraform.nix
  ];

  home.packages = with pkgs; [
    awless
    aws-vault
    awscli2
    certigo
    chamber
    glab
    gomplate
    graphviz
    jwt-cli
    packer
    parallel
    vault-bin
    velero
    vendir
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".aws"
        ".awsvault"
        ".config/infractl"
      ];
      allowOther = true;
    };
  };
}
