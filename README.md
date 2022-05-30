# ❄️ NixOS Configuration

## Screenshot

![Screenshot](screenshot.png)

## Organization

| Dir/File  | Description                                                   |
| --------- | ------------------------------------------------------------- |
| config    | Common system configuration and components                    |
| hardware  | Hardware-specific configuration. Imported by hosts            |
| home      | Application-specific components (aka dotfiles)                |
| hosts     | Host-specific configuration                                   |
| pkgs      | Nix packages not found in the official Nix package repository |
| flake.nix | Flake configuration which ties everything together            |
