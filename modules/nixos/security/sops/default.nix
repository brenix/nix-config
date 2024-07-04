{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.security.sops;
  key = builtins.elemAt (builtins.filter (k: k.type == "ed25519") config.services.openssh.hostKeys) 0;
in {
  options.${namespace}.security.sops = {
    enable = mkBoolOpt false "Whether to enable SOPS for secrets management.";
  };

  config = mkIf cfg.enable {
    sops = {
      gnupg = {
        home = "~/.gnupg";
        sshKeyPaths = [];
      };
      age.sshKeyPaths = [key.path];
    };
  };
}
