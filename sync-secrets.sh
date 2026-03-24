#!/bin/bash
set -euo pipefail

# Sync gitignored secret/config files from projects to another PC
# Usage: ./sync-secrets.sh <target-ip>

TARGET_IP="${1:?Usage: $0 <target-ip>}"
TARGET_USER="${SYNC_USER:-hesounj}"
SRC="$HOME/projects"

# Use sshpass to avoid repeated password prompts
if ! command -v sshpass &>/dev/null; then
  echo "Installing sshpass..."
  sudo dnf install -y sshpass
fi

read -rsp "SSH password for $TARGET_USER@$TARGET_IP: " SSHPASS
echo
export SSHPASS

SSH_OPTS=(-o StrictHostKeyChecking=accept-new)
RSYNC_SSH="sshpass -e ssh ${SSH_OPTS[*]}"

FILES=(
  # makalu
  "makalu/application-local.properties"
  "makalu/common/src/main/resources/application-secrets.properties"
  "makalu/docker-compose/backend.env"
  "makalu/ui/.env.local"

  # porong
  "porong/porong-core/src/main/resources/secrets.conf"

  # skuta
  "skuta/common/src/main/resources/secrets.conf"

  # passwords (git-secret)
  "passwords/.gitsecret/keys/random_seed"
  "passwords/secrets/aks-network-inventory-nonprod-gwc/test/skuta.yaml"
  "passwords/secrets/aks-network-inventory-prod-gwc/prod/skuta.yaml"
)

echo "Syncing project secret files to $TARGET_USER@$TARGET_IP..."

for file in "${FILES[@]}"; do
  src_path="$SRC/$file"
  if [[ -f "$src_path" ]]; then
    dest_dir=$(dirname "$file")
    echo "  → $file"
    sshpass -e ssh "${SSH_OPTS[@]}" "$TARGET_USER@$TARGET_IP" "mkdir -p ~/projects/$dest_dir"
    rsync -az --progress -e "$RSYNC_SSH" "$src_path" "$TARGET_USER@$TARGET_IP:~/projects/$file"
  else
    echo "  ✗ $file (not found, skipping)"
  fi
done

echo "Done."
