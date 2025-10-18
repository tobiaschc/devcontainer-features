#!/bin/bash -i

set -e

source dev-container-features-test-lib

check "starship --version" starship --version
check "nerd_font_name is installed" fc-list | grep "Meslo"

reportResults
