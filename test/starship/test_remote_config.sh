#!/bin/bash -i

set -e

source dev-container-features-test-lib

check "starship --version" starship --version

check "starship remote config" bash -c "cat /home/vscode/.config/starship.toml | grep -q '# feature: ghcr.io/tobiaschc/devcontainer-features/starship'"

reportResults
