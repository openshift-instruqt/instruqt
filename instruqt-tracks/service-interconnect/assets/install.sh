#!/bin/sh

set -e

echo
echo "# Determining your OS and architecture"
echo

case `uname -s` in
    Darwin)
        OPERATING_SYSTEM=mac
        INSTALL_DIR="$HOME/bin"
        ;;
    Linux)
        OPERATING_SYSTEM=linux
        INSTALL_DIR="$HOME/.local/bin"
        ;;
    *)
        echo "Error: Unknown operating system: `uname -s`"
        exit 1
        ;;
esac

case `uname -m` in
    aarch64) ARCHITECTURE=arm64 ;;
    arm64)   ARCHITECTURE=arm64 ;;
    armv7l)  ARCHITECTURE=arm32 ;;
    i386)    ARCHITECTURE=i386  ;;
    i686)    ARCHITECTURE=i386  ;;
    x86_64)  ARCHITECTURE=amd64 ;;
    *)
        echo "Error: Unknown architecture: `uname -m`"
        exit 1
        ;;
esac

echo "  Operating system: $OPERATING_SYSTEM"
echo "  Architecture: $ARCHITECTURE"
echo

echo "# Looking up the latest release for your environment"
echo

RELEASE_URL=https://github.com/skupperproject/skupper/releases/download/1.2.6/skupper-cli-1.2.6-linux-amd64.tgz

echo "  $RELEASE_URL"
echo

echo "# Downloading and installing the Skupper command"
echo

mkdir -p "$INSTALL_DIR"
curl -fL "$RELEASE_URL" | tar -C "$INSTALL_DIR" -xzf -
echo

echo "# Testing the Skupper command"
echo

if PATH="$INSTALL_DIR:$PATH" skupper version > /dev/null; then
    echo "  Result: OK"
    echo
else
    echo "Error: Skupper command execution failed"
    exit 1
fi

echo "# The Skupper command is now available:"
echo
echo "  $INSTALL_DIR/skupper"
echo

if [ "`which skupper`" != "$INSTALL_DIR/skupper" ]; then
    echo "# Use the following command to place it on your path:"
    echo
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
    echo
fi
