#!/bin/sh

set -e

MULTICA_SOURCE_DIR="/multica/multica"
MULTICA_STATE_FILE="/multica/.initialized"

echo "======================================"
echo "Multica Initializer"
echo "======================================"

echo ""
echo "[1/4] Checking initialization status..."

if [ -f "$MULTICA_STATE_FILE" ]; then
    echo "Multica already initialized."
    echo "Skipping make selfhost."
    echo "======================================"
    echo "Multica initialization skipped."
    echo "======================================"
    exit 0
fi

echo "Multica is not initialized."

echo ""
echo "[2/4] Checking Multica repository..."

if [ ! -d "$MULTICA_SOURCE_DIR/.git" ]; then
    echo "Cloning Multica repository..."
    git clone --depth 1 \
        https://github.com/multica-ai/multica.git \
        "$MULTICA_SOURCE_DIR"
    echo "Multica repository cloned."
else
    echo "Multica repository already exists."
fi

echo ""
echo "[3/4] Running make selfhost..."

cd "$MULTICA_SOURCE_DIR"

make selfhost

echo "Multica selfhost completed."

echo ""
echo "[4/4] Marking initialization as complete..."

touch "$MULTICA_STATE_FILE"

echo "Initialization state saved."

echo ""
echo "======================================"
echo "Multica initialization complete."
echo "======================================"
