{lib, ...}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.enable = lib.mkForce false;
  hardware.networking.enable = true;

  matrix.roles = {
    desktop.addons.gnome.enable = true;
  };

  nix.enable = true;
  services = {
    openssh.enable = true;
  };

  system = {
    fonts.enable = true;
    locale.enable = true;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };

  users.users.nixos = {
    extraGroups = ["networkmanager"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGH6D2sNMsbMo6DMdwuwDjPpRBM8ZDZtQa/FG4Ape5ei"
    ];
  };

  system.stateVersion = "23.11";
}
