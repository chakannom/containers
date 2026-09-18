#!/bin/sh
set -e

echo "=================================="
echo "Multica Daemon"
echo "=================================="

echo ""
echo "[1/8] Checking Docker..."
docker --version
echo "Docker OK"

echo ""
echo "[2/8] Checking OpenCode..."
opencode --version
echo "OpenCode OK"

echo ""
echo "[3/8] Checking Hermes..."
hermes --version
echo "Hermes OK"

echo ""
echo "[4/8] Connecting Docker network..."
docker network connect multica_default multica-daemon 2>/dev/null || true
echo "Docker network connected"

echo ""
echo "[5/8] Configuring Multica server..."
multica config set server_url http://backend:8080
multica config set app_url http://frontend:8080
echo "Multica server configuration completed"

echo ""
echo "[6/8] Generating Multica PAT..."
PAT=$(get-pat dev@example.com http://backend:8080 daemon)
echo "Multica PAT generated"

echo ""
echo "[7/8] Creating workspace..."
curl -s -X POST "http://backend:8080/api/workspaces" \
  -H "Authorization: Bearer $PAT" \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"Sample Team\", \"slug\": \"sample-team\", \"issue_prefix\": \"SMPL\"}"
echo ""
echo "Workspace creation completed"

echo ""
echo "[8/8] Logging in to Multica..."
multica login --token "$PAT"
echo "Multica login completed"

echo ""
echo "=================================="
echo "Starting Multica Daemon..."
echo "=================================="

exec multica daemon start --foreground