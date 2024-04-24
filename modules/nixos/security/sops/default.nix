{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.security.sops;
  key = builtins.elemAt (builtins.filter (k: k.type == "ed25519") config.services.openssh.hostKeys) 0;
in {
  options.security.sops = with types; {
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
