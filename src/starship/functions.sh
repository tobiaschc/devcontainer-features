#!/bin/bash

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi
        apt-get -y install --no-install-recommends "$@"
    fi
}

# Helper to replace or append a config option
upsert_config_option() {
    if grep -E -q "$1" "$3"; then
        sed -i -e "s/$1/$2/" "$3"
    else
        echo "$2" >>"$3"
    fi
}

# Configure starship init line for a given shell rc file
configure_shell() {
    local shell_type="$1"
    local rc_file="$2"

    echo "Configuring Starship in $rc_file"
    local init_line="eval \"\$(starship init $shell_type)\""
    local pattern=".*starship init $shell_type.*"
    upsert_config_option "$pattern" "$init_line" "$rc_file"
}

# Install/copy Starship config into $USERHOME/.config/
install_starship_config() {
    local config="$1"
    local userhome="$2"
    local username="$3"
    local target_path="$4"

    [ -z "$config" ] && return 0

    # Create .config directory if it doesn't exist
    mkdir -p "$(dirname "$target_path")"

    # Check if config is a URL
    if [[ "$config" =~ ^https?:// ]]; then
        # Normalize GitHub blob URLs to raw URLs
        if [[ "$config" =~ github\.com/.*/blob/ ]]; then
            config="${config/github.com/raw.githubusercontent.com}"
            config="${config/\/blob\//\/}"
        fi

        echo "Downloading Starship config from: $config"
        if ! curl -fsSL "$config" -o "$target_path"; then
            echo "Warning: Failed to download Starship config from $config" >&2
            return 0
        fi
    fi

    echo "Starship config installed at: $target_path"
}
