{
  config,
  lib,
  namespace,
  format ? "",
  ...
}: let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.services.ssh;
  hasPersistence = config.environment.persistence ? "/persist";
in {
  options.${namespace}.services.ssh = with types; {
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
          else "without-password";
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

    # TODO: build failures; uncomment once fixed upstream
    # Passwordless sudo when SSH'ing with keys
    # security.pam.sshAgentAuth.enable = true;

    # Add github/gitlab known hosts system-wide
    programs.ssh.knownHosts = {
      "github.com".hostNames = ["github.com"];
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

      "gitlab.com".hostNames = ["gitlab.com"];
      "gitlab.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";
    };

    users.users = {
      ${config.${namespace}.user.name}.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGH6D2sNMsbMo6DMdwuwDjPpRBM8ZDZtQa/FG4Ape5ei"
      ];
    };
  };
}
