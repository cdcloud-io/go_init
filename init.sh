#!/usr/bin/env bash

# ==============================================================================
# Title          : Restricted Script Template
# Description    : This script can only be called from another script, not from the command line.
# Company        : cdcloud-io
# Author         : cd-stephen
# References     : [URLs or other references]
# Last Modified  : [Date of last modification]
# Version        : [Version of the script]
# Usage          : ./restricted_script.sh [arguments]
# Notes          : Ensure this script is called from another script.
# ==============================================================================

# ------------------------------------------------------------------------------
# Check if the script is run as root
# ------------------------------------------------------------------------------

if [ "$EUID" -eq 0 ]; then
  echo "Error: This script must be run as a non-root user."
  exit 1
fi

# ------------------------------------------------------------------------------
# Define constants and variables
# ------------------------------------------------------------------------------

# [Define any constants or variables needed for the script]

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# [Define any functions used in the script]

# ------------------------------------------------------------------------------
# Main Script
# ------------------------------------------------------------------------------

# Check if go.mod file exists
if [ ! -f go.mod ]; then
    # Check if the "cmd" directory exists
    if [ -d "cmd" ]; then
        echo "Directory ./cmd already exists. Initialization aborted to prevent overwriting existing code."
    else
        # Initialize Go module
        if [ -z "${URL_PATH}" ]; then
            echo "Initializing GO module..."
            go mod init "${MODULE_NAME}"
        else
            echo "Initializing GO module with URL path..."
            go mod init "${URL_PATH}"
        fi

        # Create necessary directories
        mkdir -p api cmd/"${MODULE_NAME}" bin config docs examples internal/app internal/config internal/endpoint/user internal/middleware/auth internal/middleware/trace internal/middleware/logging internal/server pkg test


        # Create README.md with the project name
        printf "# %s\n" "${MODULE_NAME}" > README.md
    fi
else
    echo "GO module already initialized."
fi