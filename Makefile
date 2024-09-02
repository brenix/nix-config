HOSTNAME ?= $(shell hostname)
USERNAME ?= $(shell whoami)
UNAME := $(shell uname)
FAST ?= 0
TRACE ?= 0

## Default target - Switch configuration
.PHONY: switch
switch:
ifeq ($(UNAME), Darwin)
	@darwin-rebuild switch --verbose $(if $(TRACE),--show-trace) --flake ".#$(HOSTNAME)"
else ifeq ($(UNAME), Linux)
	@if grep -q '^NAME=NixOS' /etc/os-release; then \
		sudo nixos-rebuild switch --verbose  $(if $(FAST),--fast) $(if $(TRACE),--show-trace) --flake ".#$(HOSTNAME)"; \
	else \
		home-manager switch $(if $(TRACE),--show-trace) --flake ".#$(USERNAME)@$(HOSTNAME)"; \
	fi
endif

.PHONY: fast
fast: FAST := 1
fast: switch

.PHONY: trace
trace: TRACE := 1
trace: switch

## Build config only
.PHONY: build
build:
ifeq ($(UNAME), Darwin)
	@darwin-rebuild build --verbose $(if $(TRACE),--show-trace) --flake ".#$(HOSTNAME)"
else ifeq ($(UNAME), Linux)
	@sudo nixos-rebuild build --verbose $(if $(TRACE),--show-trace) --flake ".#$(HOSTNAME)"
endif

## Update flake and rebuild
.PHONY: upgrade
upgrade: update switch

## Update flake
.PHONY: update
update:
	@nix flake update

## Update keys for all secrets
.PHONY: updatekeys
updatekeys:
	@fd 'secrets.ya?ml' -x sops updatekeys -y

## Generate ISO
.PHONY: iso
iso:
	@sudo nix build .#nixosConfigurations.iso.config.system.build.isoImage

## Run garbage collection
.PHONY: gc
gc:
	@sudo nh clean all
