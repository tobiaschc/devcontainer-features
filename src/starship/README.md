# Starship Plugin

Install and configure the Starship prompt in your development container.

## Example Usage

```json
"features": {
  "ghcr.io/tobiaschc/devcontainer-features/starship:1": {
    "version": "latest"
  }
}
```

## Options

| Options Id    | Description                                                                                                                                                                   | Type    | Default Value |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------------- |
| version       | The version of Starship to install.                                                                                                                                           | string  | latest        |
| defaultConfig | Whether to use my default Starship configuration.                                                                                                                             | boolean | true          |
| localConfig   | Whether to use a local Starship configuration file. This is not supported in feature installation, use mounts + postCreateCommand in devcontainer.json to copy local configs. | boolean | false         |
| configFile    | Path to a custom Starship configuration file, could be local or remote (URL). If set, this will override `defaultConfig`.                                                     | string  |               |
| nerdFont      |                                                                                                                                                                               | string  |               |

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/tobiaschc/devcontainer-features/blob/main/src/starship/devcontainer-feature.json). Add additional notes to a `NOTES.md`._
