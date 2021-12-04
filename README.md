# ❄️ NixOS Configuration

## Installation

## Organization

| Dir/File  | Description                                               |
| --------- | --------------------------------------------------------- |
| config    | Common system configuration and components                |
| hardware  | Hardware-specific configuration. Imported by hosts        |
| home      | Application-specific components (aka dotfiles)            |
| hosts     | Host-specific configuration                               |
| modules   | Nix modules that can be re-used across components         |
| user.nix  | Entrypoint for my dotfiles and overall home configuration |
| flake.nix | Flake configuration which ties everything together        |
