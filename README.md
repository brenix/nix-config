# ❄️ NixOS Configuration

## Organization

| Dir/File  | Description                                                   |
| --------- | ------------------------------------------------------------- |
| config    | Common system configuration and components                    |
| hardware  | Hardware-specific configuration. Imported by hosts            |
| home      | Application-specific components (aka dotfiles)                |
| hosts     | Host-specific configuration                                   |
| modules   | Nix modules that can be re-used across components             |
| overlays  | Custom overlays and packages to be applied to all hosts       |
| pkgs      | Nix packages not found in the official Nix package repository |
| flake.nix | Flake configuration which ties everything together            |
