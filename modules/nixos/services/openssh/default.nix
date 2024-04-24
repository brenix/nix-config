{
  config,
  lib,
  format ? "",
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.services.ssh;
  hasPersistence = config.environment.persistence ? "/persist";
in {
  options.services.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
    authorizedKeys = mkOpt (listOf str) [] "The public keys to apply.";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [22];

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin =
          if format == "install-iso"
          then "yes"
          else "no";
        StreamLocalBindUnlink = "yes";
        GatewayPorts = "clientspecified";
      };

      hostKeys = [
        {
          path = "${lib.optionalString hasPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];

      # TEMP: Fix warning about authorized keys
      authorizedKeysFiles = lib.mkForce [
        "/etc/ssh/authorized_keys.d/%u"
      ];
    };

    # Passwordless sudo when SSH'ing with keys
    security.pam.sshAgentAuth.enable = true;

    users.users = {
      ${config.user.name}.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F"
      ];
    };
  };
}
