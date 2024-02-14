{ inputs, pkgs, lib, ... }: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    gnupg = {
      home = "~/.gnupg";
      sshKeyPaths = [ ];
    };

    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";
  };

  home.packages = with pkgs; [
    sops
  ];

  # Fix issue where service is not started
  systemd.user.services.sops-nix = {
    Install = {
      WantedBy = lib.mkForce [ "basic.target" ];
    };
  };

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/sops"
      ];
    };
  };
}
