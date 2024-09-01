HOSTNAME ?= $(shell hostname)
USERNAME ?= $(shell whoami)
UNAME := $(shell uname)

## Rebuild NixOS configuration
nixos:
ifeq ($(UNAME), Darwin)
	@darwin-rebuild switch --verbose --flake ".#$(HOSTNAME)"
else
	@sudo nixos-rebuild switch --verbose --flake ".#$(HOSTNAME)"
endif

## Build config only
build:
ifeq ($(UNAME), Darwin)
	@darwin-rebuild build --verbose --flake ".#$(HOSTNAME)"
else
	@sudo nixos-rebuild switch --verbose --flake ".#$(HOSTNAME)"
endif

## Build config only using fast
build-fast:
ifeq ($(UNAME), Darwin)
	@darwin-rebuild build --verbose --fast --flake ".#$(HOSTNAME)"
else
	@sudo nixos-rebuild switch --verbose --fast --flake ".#$(HOSTNAME)"
endif

## Rebuild Home-manager configuration
home:
	@home-manager switch --flake ".#$(USERNAME)@$(HOSTNAME)"

## Update flake and rebuild
upgrade: update nixos

## Update flake
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
	@sudo nh clean all

.PHONY: nixos upgrade gc
