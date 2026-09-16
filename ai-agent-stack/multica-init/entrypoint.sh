#!/bin/sh

set -e

MULTICA_DIR="/multica"
MULTICA_STATE_FILE="/multica/.initialized"

echo "======================================"
echo "Multica Initializer"
echo "======================================"

if [ -f "$MULTICA_STATE_FILE" ]; then
  echo "Multica already initialized."
  echo "Skipping make selfhost."
  exit 0
fi

if [ ! -d "$MULTICA_DIR/.git" ]; then
  echo "Cloning Multica..."
  git clone --depth 1 \
        https://github.com/multica-ai/multica.git \
        "$MULTICA_DIR"
else
  echo "Multica repository already exists."
fi

cd "$MULTICA_DIR"

echo "Running make selfhost..."

make selfhost

echo "Multica selfhost completed."

touch "$MULTICA_STATE_FILE"

echo "======================================"
echo "Multica initialization complete."
echo "======================================"
