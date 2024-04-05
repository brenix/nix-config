## Usage

<details>
  <summary>Install</summary>
To install nixos on any of my devices I create my own ISO live media image. You can build the ISO by doing the following:

### Step 1 - Populate host configuration

1. Create a new directory under `hosts/`
1. Copy from an existing host or create the `configuration.nix`, `disks.nix`,
   `home.nix`, and any other necessary files to the new host directory
1. Edit the `flake.nix` and add a new entry under the nixosConfigurations and
   homeConfigurations

### Step 2 - Build ISO

```sh
make iso
```

### Step 3 - Boot the ISO

Boot the ISO via USB or directly (if using qemu)

### Step 4 - Update SOPS keys

In order to decrypt the secrets, an age publickey needs to be added to the sops
configuration

Remotely:

```sh
nix-shell -p ssh-to-age --run 'ssh-keyscan <ip/hostname> | ssh-to-age'
```

Locally:

```sh
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

Add this to the `.sops.yaml` file for the host, following the existing pattern.

Then, update all of the sops secret files:

```sh
fd secrets.yaml -x sops updatekeys -y
```

### Step 5 - Install

Call the installer script from the booted ISO

```sh
nix-installer
```

</details>

## Features

Some features of my nix-config:

- Structured to allow multiple **NixOS configurations**, such as desktop or
  headless hosts
- **Declarative** config including **themes**, **wallpapers** and **nix-colors**
- **Opt-in persistance** through impermanence + blank snapshot
- **sops-nix** for secrets management
- Different desktops/wms like **hyprland** or **bspwm**
- Custom live media **ISO**, with an **"automated" install** script

## Structure

- `flake.nix`: Entrypoint for hosts and home configurations
- `nixos`:
  - `global`: Configurations that are globally applied to all my machines
  - `optional`: Configurations that some of my machines use
- `hosts`: NixOS Configurations, accessible via `nixos-rebuild --flake`.
  - `neo`: Primary desktop
  - `morpheus`: Primary laptop
  - `trinity`: Kubernetes host
- `home-manager`: Most of my nix-config configuration, home-manager modules

## Inspired By

- https://github.com/Misterio77/nix-config
- https://github.com/hmajid2301/dotfiles
