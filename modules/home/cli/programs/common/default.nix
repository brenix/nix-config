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
    programs.ripgrep = {
      enable = true;
      arguments = [
        "--max-columns=150"
        "--max-columns-preview"
        "--glob=!.git/*"
        "--smart-case"
      ];
    };

    programs.fd = {
      enable = true;
      hidden = true;
      extraOptions = [
        "--no-ignore"
        "--absolute-path"
      ];
      ignores = [
        ".git/"
      ];
    };

    home.packages = with pkgs; [
      age
      # awscli2
      certigo
      curlie
      dig
      dysk
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
