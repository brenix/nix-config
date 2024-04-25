HOSTNAME ?= $(shell hostname)

## Rebuild NixOS configuration
nixos:
	@sudo nixos-rebuild switch --verbose --flake ".#$(HOSTNAME)"

## Update flake and rebuild
upgrade: update
	@sudo nixos-rebuild switch --verbose --flake ".#$(HOSTNAME)"

## Rebuild and upgrade NixOS configuration
update:
	@nix flake update

## Update keys for all secrets
updatekeys:
	@fd 'secrets.ya?ml' -x sops updatekeys

## Generate ISO
iso:
	@sudo sudo nix build .#nixosConfigurations.iso.config.system.build.isoImage

## Run garbage collection
gc:
	@sudo nix-collect-garbage -d

.PHONY: nixos upgrade gc
