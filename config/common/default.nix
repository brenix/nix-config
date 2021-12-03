{ pkgs, ... }: {

  imports = [
    ./boot.nix
    ./fonts.nix
    ./i18n.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./services.nix
    ./sysctl.nix
    ./system.nix
    ./users.nix
  ];

}
