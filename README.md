[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

# ❄️ Nix Configuration

My NixOS and home-manager configuration files

## Screenshot

![Screenshot](screenshot.png)

## Organization

| Dir/File  | Description                                                   |
| --------- | ------------------------------------------------------------- |
| home      | Application-specific components (aka dotfiles)                |
| hosts     | NixOS configurations                                          |
| lib       | Functions to make the flake cleaner                           |
| modules   | A few actual modules (with options) not available upstream    |
| overlay   | Patches and version overrides for some packages               |
| pkgs      | Nix packages not found in the official Nix package repository |
| flake.nix | Flake configuration which ties everything together            |

## About the installation

All systems use a single btrfs partition, with subvolumes for `/nix`, a
`/persist` directory (which is opt-in using `impermanence`), and a
root subvolume (cleared on every boot).

Home-manager is used in a standalone way, and because of opt-in persistence is
activated on every boot with `loginShellInit`.

## My install process

This may not be the most optimal way to install, but it is what I have found which works.

First, download and boot the official [NixOS ISO](https://nixos.org/download.html#nixos-iso) or [Netboot.xyz](https://netboot.xyz/downloads/)

Install git

    nix-env -i git

Clone this repo

    git clone https://github.com/brenix/nix-config

Enter a development shell

    nix --extra-experimental-features "nix-command flakes" develop

Format and mount the partitions

    sudo make volumes HOSTNAME=<hostname> DISK=/dev/<disk>

Copy the livecd host keys to the persistence dir

    sudo make host-keys
    sudo mkdir -p /mnt/persist/etc/ssh && cp /etc/ssh/ssh_host\* /mnt/persist/etc/ssh

Update the `.sops.yaml` with the age pubkey obtained using the following command on another nix host

    nix-shell -p ssh-to-age --run 'ssh-keyscan <ip/hostname> | ssh-to-age'

Re-encrypt with the new keys

    sops updatekeys -y path/to/secrets.yaml

Install the host configuration

    sudo -E nixos-install --impure --no-root-passwd --flake .#<hostname>

Reboot, then login as the user (may need to switch to another virtual console) and install the home configuration

    git clone https://github.com/brenix/nix-config && cd nix-config
    nix --extra-experimental-features "nix-command flakes" develop
    make home
