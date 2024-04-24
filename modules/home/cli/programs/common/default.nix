{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.programs.common;
in {
  options.cli.programs.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      age
      # awscli2
      certigo
      curlie
      dig
      dysk
      fd
      gcc
      gettext
      gnumake
      gomplate
      go-task
      # graphviz
      htop
      hugo
      imagemagick
      jq
      jwt-cli
      libqalculate
      nmap
      # ouch
      # packer
      postgresql
      ripgrep
      sd
      shfmt
      unrar
      unzip
      vault-bin
      wireguard-tools
      yq-go
    ];
  };
}
