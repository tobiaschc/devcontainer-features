# Devcontainer Features

[![Tests](https://github.com/tobiaschc/devcontainer-features/actions/workflows/test.yaml/badge.svg)](https://github.com/tobiaschc/devcontainer-features/actions/workflows/test.yaml)

This repo contains my custom DevContainer Features.

You can learn more about Features at https://containers.dev/implementors/features/.

## Features

| Feature                    | Description                                                          |
| -------------------------- | -------------------------------------------------------------------- |
| [starship](./src/starship) | Install and configure Starship prompt in your development container. |

## Usage

To reference a Feature from this repository, add it to your `devcontainer.json`. Each Feature has a `README.md` with details and options.

Example using the `starship` feature:

```jsonc
"name": "my-project-devcontainer",
"image": "mcr.microsoft.com/devcontainers/base:ubuntu",
"features": {
  "ghcr.io/tobiaschc/devcontainer-features/starship:1": {},
  "customizations": {
        "vscode": {
            "settings": {
                "terminal.integrated.fontFamily": "MesloLGS Nerd Font Mono",
            }
        }
    }
}
```
