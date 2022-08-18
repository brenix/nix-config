NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM = 1
DISK ?=
USER ?= brenix
HOSTNAME ?= $(shell hostname)

# Ensures that a variable is defined and non-empty
define assert-set
	@$(if $($(1)),,$(error $(1) not defined in $(@)))
endef

## Rebuild NixOS and home-manager configurations
switch: nixos home

## Rebuild NixOS configuration
nixos:
	@sudo nixos-rebuild switch --verbose --impure --upgrade-all --recreate-lock-file --flake ".#$(HOSTNAME)"

## Rebuild home-manager configuration
home:
	@home-manager --flake ".#$(USER)@$(HOSTNAME)" switch

## Run garbage collection
gc:
	@sudo nix-collect-garbage -d

## Partition and format btrfs volumes for install
volumes:
	$(call assert-set,DISK)
	@{ \
	umount -R /mnt 2>/dev/null; \
	parted -s $(DISK) -- mklabel gpt; \
	parted -s $(DISK) -- mkpart ESP fat32 1MiB 512MiB; \
	parted -s $(DISK) -- mkpart primary 512MiB 100%; \
	parted -s $(DISK) -- set 1 esp on; \
	parted -s $(DISK) -- name 1 ESP; \
	parted -s $(DISK) -- name 2 $(HOSTNAME); \
	mkfs.fat -F32 -n ESP $(DISK)1; \
	mkfs.btrfs -f -L $(HOSTNAME) $(DISK)2; \
	sleep 5; \
	mount /dev/disk/by-label/$(HOSTNAME) /mnt; \
	mkdir -p /mnt/boot; \
	mount /dev/disk/by-label/ESP /mnt/boot; \
	btrfs subvolume create /mnt/root; \
	btrfs subvolume create /mnt/persist; \
	btrfs subvolume create /mnt/nix; \
	btrfs subvolume snapshot -r /mnt/root /mnt/root-blank; \
	}

.PHONY: switch nixos home gc test volumes
