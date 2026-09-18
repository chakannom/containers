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

docker network connect multica_default multica-daemon

multica config set server_url http://backend:8080
multica config set app_url http://frontend:8080

# TODO generate mul_xxxxx...
# TODO multica login --token mul_xxxxx

# echo "Starting Multica Daemon..."

# exec multica daemon start --foreground

sleep infinity