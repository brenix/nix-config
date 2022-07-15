export NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM = 1
export NIX_REPO ?= https://github.com/brenix/nixos-config
export NIX_CONFIG ?= $(shell hostname)
export NIX_DISK ?=
export NIX_HOST ?=
export SSH_OPTIONS ?= -o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

switch:
	@sudo nixos-rebuild switch --verbose --impure --upgrade-all --flake ".#$(NIX_CONFIG)"

gc:
	@sudo nix-collect-garbage -d

test:
	@unset NIX_CONFIG; nix --extra-experimental-features 'nix-command flakes' --impure flake check

install:
	@ssh $(SSH_OPTIONS) root@$(NIX_HOST) " \
		umount -R /mnt 2>/dev/null; \
		parted -s /dev/$(NIX_DISK) -- mklabel gpt; \
		parted -s /dev/$(NIX_DISK) -- mkpart ESP fat32 1MiB 512MiB; \
		parted -s /dev/$(NIX_DISK) -- mkpart primary 512MiB 100%; \
		parted -s /dev/$(NIX_DISK) -- set 1 esp on; \
		parted -s /dev/$(NIX_DISK) -- name 1 boot; \
		parted -s /dev/$(NIX_DISK) -- name 2 nixos; \
		mkfs.fat -F32 -n boot /dev/$(NIX_DISK)1; \
		mkfs.ext4 -m0 -F -L nixos /dev/$(NIX_DISK)2; \
		sleep 5; \
		mount /dev/disk/by-label/nixos /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/disk/by-label/boot /mnt/boot; \
		nix-shell -p git --run 'git clone $(NIX_REPO) /mnt/etc/nixos'; \
		nix-shell -p git nixFlakes --run 'nixos-install --impure --no-root-passwd --root /mnt --flake /mnt/etc/nixos#$(NIX_CONFIG)'; \
	"
