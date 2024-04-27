<div align="center">
<h1>
<img width="96" src="./images/logo.png"></img> <br>
  Nix Config
</h1>
<!-- <img src="./images/terminal.png"></img> -->
<h4>
  :warning: This config repo is constantly changing and may be refactored often.
</h4>
</div>

## 💽 Usage

### Install

To remotely install NixOS onto a target system, I use
[nixos-anywhere](https://github.com/nix-community/nixos-anywhere/blob/main/docs/howtos/no-os.md).

**On the target system**:

1. Boot the NixOS iso
1. Configure SSH authorized keys to enable SSH into the system

   ```sh
   [nixos@nixos:~]$ mkdir .ssh && curl https://github.com/brenix.keys > .ssh/authorized_keys
   ```

1. Note the IP address of the system

**On a separate NixOS host**:

1. Pull or `cd` to the directory for this repository
1. Enter the dev shell

   ```sh
   $ nix develop
   ```

1. Run ssh-to-age to get a pubkey for SOPS

   ```sh
   $ ssh-keyscan $TARGET_HOST | ssh-to-age
   ```

1. Update the [`.sops.yaml`](.sops.yaml) file and add a new host to the keys and
   creation rules
1. Update all of the secrets in the repo to include the new key

   ```sh
   $ make updatekeys
   ```

1. Run nixos-anywhere to remotely install NixOS on the target system

   ```sh
   $ nixos-anywhere --no-reboot --flake '.#neo' nixos@192.168.1.9 # Replace with the target system IP from above
   ```

**On the target system**:

1. Copy the livecd ssh host keys to the persist directory

   ```sh
   $ sudo mkdir -p /mnt/persist/etc/ssh && sudo cp /etc/ssh/ssh_host_ed25519* /mnt/persist/etc/ssh/
   ```

### Building

To build my nix-config for a specific host you can do something like:

```sh
git clone git@github.com:brenix/nix-config.git ~/nix-config/
cd nix-config

nix develop

# To build system configuration
sudo nixos-rebuild switch --flake .#framework

# To build user configuration
home-manager switch --flake .#haseeb@framework
```

## 🚀 Features

Some features of my nix-config:

- Structured to allow multiple **NixOS configurations**, including **desktop**,
  **laptop**
- **Declarative** config including **themes**, **wallpapers** and **nix-colors**
- **Opt-in persistance** through impermanence + blank snapshot
- **Encrypted btrfs partition**
- **sops-nix** for secrets management
- Custom live media **ISO**, with an **"automated" install** script
- Supports **vfio** for playing games on Windows

## 🏠 Hosts

- `neo`: My primary desktop computer
- `morpheus`: Framework 13th gen laptop
- `trinity`: My spare desktop now used as a K8S server
- `macbook`: Apple macbook laptop
- `vm`: Qemu VM for testing
- `iso`: Builds custom installer ISO

## 📱 Applications

| Type           |                          Program                          |
| :------------- | :-------------------------------------------------------: |
| OS             |                [NixOS](https://nixos.com/)                |
| Editor         |             [Helix](https://helix-editor.com)             |
| Multiplexer    |           [Tmux](https://github.com/tmux/tmux)            |
| Prompt         |             [Starship](https://starship.rs/)              |
| Launcher       |        [Rofi](https://github.com/davatorium/rofi)         |
| Shell          |              [Fish](https://fishshell.com/)               |
| Status Bar     |        [Waybar](https://github.com/Alexays/Waybar)        |
| Terminal       |          [Foot](https://codeberg.org/dnkl/foot)           |
| Window Manager |             [Hyprland](https://hyprland.org/)             |
| Fonts          | [Monaco](https://en.wikipedia.org/wiki/Monaco_(typeface)) |
| Colorscheme    |     [Catppuccin Mocha](https://github.com/catppuccin)     |

## 🖼️ Showcase

WIP

## Acknowledgements

- A lot of the configuration and inspiration comes from
  https://github.com/hmajid2301/dotfiles
- For some additional snowfall/darwin config:
  https://github.com/jakehamilton/config
- Originally inspired by https://github.com/Misterio77/nix-config
