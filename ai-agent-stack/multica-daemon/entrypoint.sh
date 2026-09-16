#!/bin/sh

set -e

echo "=================================="
echo "Multica Daemon"
echo "=================================="

echo "Docker:"
docker --version

echo "Checking OpenCode..."
opencode --version

echo "Checking Hermes..."
hermes --version

multica setup self-host \
    --server-url http://multica-backend-1:8080 \
    --app-url http://multica-frontend-1:3000

# TODO generate mul_xxxxx...
# TODO multica login --token mul_xxxxx

# echo "Starting Multica Daemon..."

# exec multica daemon start --foreground

sleep infinity