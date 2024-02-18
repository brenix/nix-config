{ config, lib, ... }:
let
  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persist
  hasPersistence = config.environment.persistence ? "/persist";
in
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
    };

    hostKeys = [
      {
        path = "${lib.optionalString hasPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        bits = 4096;
        path = "${lib.optionalString hasPersistence "/persist"}/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
    ];

    # Fix deprecation warning. Something else is adding "%h/.ssh/authorized_keys"
    # which is not needed since the below configuration includes the users pubkey
    authorizedKeysFiles = lib.mkForce [
      "/etc/ssh/authorized_keys.d/%u"
    ];
  };

  # Passwordless sudo when SSH'ing with keys
  security.pam.sshAgentAuth.enable = true;
}
