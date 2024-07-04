{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.atuin;

  atuin-export-fish = pkgs.buildGoModule rec {
    pname = "atuin-export-fish-history";
    version = "0.1.0";

    src = pkgs.fetchFromGitLab {
      owner = "hmajid2301";
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-2egZYLnaekcYm2IzPdWAluAZogdi4Nf/oXWLw8+AnMk=";
    };

    vendorHash = "sha256-hLEmRq7Iw0hHEAla0Ehwk1EfmpBv6ddBuYtq12XdhVc=";

    ldflags = ["-s" "-w"];
  };
in {
  options.${namespace}.programs.terminal.tools.atuin = {
    enable = mkBoolOpt false "Whether or not to enable atuin";
  };

  config = mkIf cfg.enable {
    home.packages = [atuin-export-fish];

    programs.atuin = {
      enable = true;
      flags = [
        "--disable-up-arrow"
      ];
      settings = {
        sync_address = "https://sh.brenix.com";
        sync_frequency = "15m";
        dialect = "us";
        enter_accept = false;
        records = true;
        # key_path = config.sops.secrets.atuin_key.path;
      };
    };

    sops.secrets.atuin_key = {
      sopsFile = ../../../secrets.yaml;
    };
  };
}
