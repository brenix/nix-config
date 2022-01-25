{ config, ... }: {

  imports = [ ../modules/settings.nix ];

  nix.buildMachines = [
    {
      hostName = "trinity";
      system = "x86_64-linux";
      sshUser = config.settings.username;
      sshKey = "/home/${config.settings.username}/.ssh/id_ed25519";
      maxJobs = 4;
    }
  ];

  nix.distributedBuilds = true;
}
