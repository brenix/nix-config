HOSTNAME ?= $(shell hostname)
USERNAME ?= $(shell whoami)
UNAME := $(shell uname)

## Rebuild NixOS configuration
nixos:
ifeq ($(UNAME), Darwin)
	@darwin-rebuild switch --verbose --flake ".#$(HOSTNAME)"
else
	@nh os switch
endif

## Rebuild Home-manager configuration
home:
	@nh home switch

## Update flake and rebuild
upgrade: update
	@nh os switch

## Rebuild and upgrade NixOS configuration
update:
	@nix flake update

## Update keys for all secrets
updatekeys:
	@fd 'secrets.ya?ml' -x sops updatekeys -y

## Generate ISO
iso:
	@sudo sudo nix build .#nixosConfigurations.iso.config.system.build.isoImage

## Run garbage collection
gc:
	@nh clean all

.PHONY: nixos upgrade gc
