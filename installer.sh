#!/bin/sh

# references: https://github.com/mamba-org/micromamba-releases
# references: https://raw.githubusercontent.com/mamba-org/micromamba-releases/main/install.sh

set -eu

# Detect the shell from which the script was called
parent=$(ps -o comm $PPID |tail -1)
parent=${parent#-}  # remove the leading dash that login shells have
case "$parent" in
  bash|fish|zsh)
    shell=$parent
    ;;
  *)
    # use the login shell (basename of $SHELL) as a fallback
    shell=${SHELL##*/}
    ;;
esac

echo "Parent shell: $parent"

find_writable_path_dir() {
    # Get the PATH environment variable
    path=$PATH

    # Split the PATH into an array using ':' as the delimiter
    IFS=':' read -ra dirs <<< "$path"

    # Reverse the order of the directories
    reversed_dirs=()
    for ((i=${#dirs[@]}-1; i>=0; i--)); do
        reversed_dirs+=("${dirs[i]}")
    done

    # Check and return the first writable directory
    for dir in "${reversed_dirs[@]}"; do
        if [ -w "$dir" ]; then
            echo "$dir"
            return 0
        fi
    done

    # If no writable directories are found, return "~/.local/bin"
    echo "~/.local/bin"
}

# Call the function and store the result in a variable
writable_path_dir=$(find_writable_path_dir)

# Parsing arguments
if [ -t 0 ] ; then
  printf "comfycli install binary folder? [$writable_path_dir] "
  read BIN_FOLDER

  # if BIN_FOLDER is empty, set it to the presented value
  BIN_FOLDER="${BIN_FOLDER:-$writable_path_dir}"

  # printf "Init shell ($shell)? [Y/n] "
  # read INIT_YES
  # printf "Configure conda-forge? [Y/n] "
  # read CONDA_FORGE_YES
fi

# # Fallbacks
# INIT_YES="${INIT_YES:-yes}"
# CONDA_FORGE_YES="${CONDA_FORGE_YES:-yes}"

# Computing artifact location
case "$(uname)" in
  Linux)
    PLATFORM="linux" ;;
  Darwin)
    PLATFORM="osx" ;;
  *NT*)
    PLATFORM="win" ;;
esac

ARCH="$(uname -m)"
case "$ARCH" in
  aarch64|ppc64le|arm64)
      ;;  # pass
  *)
    ARCH="64" ;;
esac

case "$PLATFORM-$ARCH" in
  linux-aarch64|linux-ppc64le|linux-64|osx-arm64|osx-64|win-64)
      ;;  # pass
  *)
    echo "Failed to detect your OS" >&2
    exit 1
    ;;
esac

if [ "${VERSION:-}" = "" ]; then
  RELEASE_URL="https://github.com/mamba-org/micromamba-releases/releases/latest/download/micromamba-${PLATFORM}-${ARCH}"
else
  RELEASE_URL="https://github.com/mamba-org/micromamba-releases/releases/download/micromamba-${VERSION}/micromamba-${PLATFORM}-${ARCH}"
fi

echo $BIN_FOLDER
echo $PLATFORM-$ARCH
echo $RELEASE_URL