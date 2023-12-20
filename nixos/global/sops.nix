{ inputs, config, ... }:
let
  key = builtins.elemAt (builtins.filter (k: k.type == "ed25519") config.services.openssh.hostKeys) 0;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../secrets.yaml;
    age.sshKeyPaths = [ key.path ];
    gnupg.sshKeyPaths = [ ];
  };
}
