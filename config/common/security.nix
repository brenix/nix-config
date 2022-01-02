{ config, ... }: {

  imports = [ ../../modules/settings.nix ];

  # Prevent replacing the running kernel image
  security.protectKernelImage = true;

  # Dont prompt for sudo password
  security.sudo.wheelNeedsPassword = false;

  # Disable sudo
  # security.sudo.enable = false;

  # Enable doas
  security.doas.enable = true;

  # Configure doas
  security.doas.extraRules = [{
    users = [ config.settings.username ];
    keepEnv = true;
    noPass = true;
  }];

}
