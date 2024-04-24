{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.security.sops;
in {
  options.security.sops = with types; {
    enable = mkBoolOpt false "Whether to enable SOPS for secrets management.";
  };

  imports = with inputs; [
    sops-nix.homeManagerModules.sops
  ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sops
    ];

    home.sessionVariables.SOPS_AGE_KEY_FILE = "/home/${config.matrix.user.name}/.config/sops/age/keys.txt";

    sops = {
      age = {
        generateKey = true;
        keyFile = "/home/${config.matrix.user.name}/.config/sops/age/keys.txt";
        sshKeyPaths = ["/home/${config.matrix.user.name}/.ssh/id_ed25519"];
      };

      defaultSymlinkPath = "/run/user/1000/secrets";
      defaultSecretsMountPoint = "/run/user/1000/secrets.d";
    };
  };
}
