{
  config,
  inputs,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.security.sops;
in {
  options.${namespace}.security.sops = {
    enable = mkBoolOpt false "Whether to enable SOPS for secrets management.";
  };

  imports = with inputs; [
    sops-nix.homeManagerModules.sops
  ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sops
    ];

    home.sessionVariables.SOPS_AGE_KEY_FILE = "/home/${config.${namespace}.user.name}/.config/sops/age/keys.txt";

    sops = {
      age = {
        generateKey = true;
        keyFile = "/home/${config.${namespace}.user.name}/.config/sops/age/keys.txt";
        sshKeyPaths = ["/home/${config.${namespace}.user.name}/.ssh/id_ed25519"];
      };

      defaultSymlinkPath = "/run/user/1000/secrets";
      defaultSecretsMountPoint = "/run/user/1000/secrets.d";
    };
  };
}
