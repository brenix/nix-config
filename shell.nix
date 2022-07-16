{ mkShell, nix, home-manager, git, age, deploy-rs, sops, ... }:
mkShell {
  nativeBuildInputs = [
    age
    deploy-rs.deploy-rs
    git
    home-manager
    nix
    sops
  ];
}
