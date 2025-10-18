#!/bin/bash
set -ex

# Install Starship
NERD_FONT=${NERD_FONT:-"Meslo"}
USERNAME="${USERNAME:-$_REMOTE_USER}"
STARSHIP_DEFAULT=${DEFAULTCONFIG:-"true"}
STARSHIP_LOCAL=${LOCALCONFIG:-"false"}
STARSHIP_CONFIG=${CONFIGFILE:-""}

# Set username and home directory
if [ "$USERNAME" = "root" ]; then
	USERNAME="root"
	USERHOME="/root"
else
	USERNAME=""
	USERHOME=""
	POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
	for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
		if id -u "${CURRENT_USER}" >/dev/null 2>&1; then
			echo "Found user: ${CURRENT_USER}"
			USERNAME=${CURRENT_USER}
			USERHOME=$(su - "${USERNAME}" -c 'echo ${HOME}')
			echo "Using home directory: ${USERHOME}"
			break
		fi
	done
fi

# Source shared helper functions
source functions.sh

check_packages ca-certificates fontconfig curl unzip

# Install the specified Nerd Font
if [ -n "$NERD_FONT" ]; then
	echo "Installing Nerd Font: $NERD_FONT"
	HOME="$USERHOME" nerd_font_name="$NERD_FONT" bash <(curl -fsSL https://raw.githubusercontent.com/monoira/nefoin/main/install.sh)
	fc-cache -fv
fi

# Install Starship if not installed
if ! command -v starship >/dev/null 2>&1; then
	curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi

# Choose existing shell rc
echo "Configuring Starship shell integration for user: $USERNAME"
ZSH_RC="$USERHOME/.zshrc"
BASH_RC="$USERHOME/.bashrc"

# Configure supported shells
[ -f "$ZSH_RC" ] && configure_shell "zsh" "$ZSH_RC"
[ -f "$BASH_RC" ] && configure_shell "bash" "$BASH_RC"

# Error if neither shell is available
if [ ! -f "$ZSH_RC" ] && [ ! -f "$BASH_RC" ]; then
	echo "No supported shell configuration files found. Please check https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship"
	exit 1
fi

# Local config case (not supported)
if [ "$STARSHIP_LOCAL" = "true" ]; then
	echo "Local configuration is not supported."
	echo "Use mounts + postCreateCommand in devcontainer.json to copy local configs."
	echo ""
	echo "Example:"
	echo "  \"mounts\": ["
	echo "    \"source=\${localEnv:HOME}/.config/starship.toml,target=/tmp/starship-config.toml,type=bind\""
	echo "  ],"
	echo "  \"postCreateCommand\": \"cp /tmp/starship-config.toml ~/.config/starship.toml\""
	exit 0
fi

# Default config case
if [ "$STARSHIP_DEFAULT" = "true" ] && [ -z "$STARSHIP_CONFIG" ]; then
	echo "Using default Starship configuration."
	exit 0
fi

# Fallback to tobias config by default
if [ "$STARSHIP_CONFIG" = "tobias" ] || [ "$STARSHIP_CONFIG" = "" ]; then
	STARSHIP_CONFIG="https://raw.githubusercontent.com/tobiaschc/dotfiles/main/starship/starship.toml"
fi

echo "Using custom Starship configuration from: $STARSHIP_CONFIG"
TARGET_PATH="$USERHOME/.config/starship.toml"
install_starship_config "$STARSHIP_CONFIG" "$USERHOME" "$USERNAME" "$TARGET_PATH"
