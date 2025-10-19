
# Starship Plugin (starship)

Install and configure Starship prompt in your development container.

## Example Usage

```json
"features": {
    "ghcr.io/tobiaschc/devcontainer-features/starship:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| defaultConfig | Whether to use my default Starship configuration. | boolean | true |
| configFile | Path to a custom Starship configuration file. If set, this will override `defaultConfig`. | string | - |
| localConfig | Whether to use a local Starship configuration file. This is not supported in feature installation, use mounts + postCreateCommand in devcontainer.json to copy local configs. | boolean | false |
| nerdFont | The Nerd Font to install for proper Starship prompt rendering. | string | Meslo |

## OS, Distribution and Architecture support

This feature supports Debian-based containers (APT package manager).

Supported architectures: `amd64`, `arm64`

Supported distributions: `ubuntu`, `debian`

Supported shells: `bash`, `zsh`

## Changelog

| Version | Notes           |
| ------- | --------------- |
| 1.0.0   | Initial release |


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/tobiaschc/devcontainer-features/blob/main/src/starship/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
