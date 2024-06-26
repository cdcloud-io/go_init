alias go_init='function _setup_makefile() {
    wget -q https://raw.githubusercontent.com/cdcloud-io/go_init/main/Makefile -O Makefile;
    wget -q https://raw.githubusercontent.com/cdcloud-io/go_init/main/.gitignore -O .gitignore;
    
    # Extract the ARTIFACT_NAME from the current directory name
    ARTIFACT_NAME=$(basename "$(pwd)")
    
    # Extract the URL_PATH from the Git configuration if a .git directory exists
    if [ -d ".git" ]; then
        GIT_URL=$(git config --get remote.origin.url)
        echo "GIT_URL: $GIT_URL"
        URL_PATH=$(echo "$GIT_URL" | sed -E "s|git@([^:]+):([^/]+/[^/]+)\.git$|\\1/\\2|")
        echo "GO MOD: $URL_PATH"
    else
        URL_PATH=""
    fi
    
    # Use sed to replace the placeholders in the Makefile
    sed -i "s|^ARTIFACT_NAME :=.*|ARTIFACT_NAME := $ARTIFACT_NAME|" Makefile
    sed -i "s|^URL_PATH :=.*|URL_PATH := $URL_PATH|" Makefile

    echo "Makefile has been set up with ARTIFACT_NAME: $ARTIFACT_NAME and URL_PATH: $URL_PATH"
}; _setup_makefile'
