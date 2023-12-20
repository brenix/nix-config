HOSTNAME ?= $(shell hostname)

## Rebuild NixOS configuration
nixos:
	@sudo nixos-rebuild switch --verbose --impure --flake ".#$(HOSTNAME)"

## Rebuild and upgrade NixOS configuration
upgrade:
	@sudo nixos-rebuild switch --verbose --impure --upgrade-all --recreate-lock-file --flake ".#$(HOSTNAME)"

## Generate ISO
iso:
	@sudo sudo nix build --impure .#nixosConfigurations.iso.config.system.build.isoImage

## Run garbage collection
gc:
	@sudo nix-collect-garbage -d

.PHONY: nixos upgrade gc
