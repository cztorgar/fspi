#!/bin/bash
set -euo pipefail

# Sync user configs, credentials, and tool settings to another PC
# Usage: ./sync-configs.sh <target-ip>
#
# This script transfers dotfiles, tool configs, and credentials
# that are NOT managed by the fspi install script (which handles
# sway, waybar, foot, wezterm, dunst, git aliases, nvim, etc.)

TARGET_IP="${1:?Usage: $0 <target-ip>}"
TARGET_USER="${SYNC_USER:-hesounj}"
TARGET="$TARGET_USER@$TARGET_IP"

# Use sshpass to avoid repeated password prompts
if ! command -v sshpass &>/dev/null; then
  echo "Installing sshpass..."
  sudo dnf install -y sshpass
fi

read -rsp "SSH password for $TARGET: " SSHPASS
echo
export SSHPASS

SSH_OPTS=(-o StrictHostKeyChecking=accept-new)
RSYNC_SSH="sshpass -e ssh ${SSH_OPTS[*]}"

do_ssh() {
  sshpass -e ssh "${SSH_OPTS[@]}" "$@"
}

sync_file() {
  local src="$1"
  local dest="${2:-$1}"  # default: same relative path

  if [[ -f "$HOME/$src" ]]; then
    local dest_dir
    dest_dir=$(dirname "$dest")
    echo "  → ~/$src"
    do_ssh "$TARGET" "mkdir -p ~/$dest_dir"
    rsync -az -e "$RSYNC_SSH" "$HOME/$src" "$TARGET:~/$dest"
  else
    echo "  ✗ ~/$src (not found, skipping)"
  fi
}

sync_dir() {
  local src="$1"
  local dest="${2:-$1}"

  if [[ -d "$HOME/$src" ]]; then
    echo "  → ~/$src/"
    do_ssh "$TARGET" "mkdir -p ~/$dest"
    rsync -az -e "$RSYNC_SSH" "$HOME/$src/" "$TARGET:~/$dest/"
  else
    echo "  ✗ ~/$src/ (not found, skipping)"
  fi
}

# =========================================================
echo "=== SSH & GPG ==="
# =========================================================
sync_dir  ".ssh"
sync_dir  ".gnupg"

# =========================================================
echo "=== Git ==="
# =========================================================
sync_file ".gitconfig"
sync_dir  ".gitconfig.d"
sync_file ".git-credentials"
sync_file ".config/git/ignore"

# =========================================================
echo "=== Shell ==="
# =========================================================
sync_file ".zshrc"
sync_file ".bashrc"
sync_file ".bash_aliases"
sync_file ".zsh_alias"
sync_file ".aliases"
sync_file ".tmux.conf"
sync_file ".pam_environment"

# =========================================================
echo "=== Build tools (Maven, Gradle, NPM) ==="
# =========================================================
sync_file ".m2/settings.xml"
sync_file ".gradle/gradle.properties"
sync_file ".npmrc"
sync_file ".testcontainers.properties"

# =========================================================
echo "=== Docker ==="
# =========================================================
sync_dir  ".docker"

# =========================================================
echo "=== Kubernetes & Azure ==="
# =========================================================
sync_dir  ".kube"
sync_dir  ".azure"

# =========================================================
echo "=== PostgreSQL ==="
# =========================================================
sync_file ".pgpass"

# =========================================================
echo "=== Claude Code ==="
# =========================================================
sync_file ".claude.json"
sync_file ".claude/settings.json"
sync_file ".claude/.credentials.json"
sync_dir  ".claude/commands"

# =========================================================
echo "=== AI tools ==="
# =========================================================
sync_file ".config/opencode/opencode.json"
sync_dir  ".config/github-copilot"

# =========================================================
echo "=== k9s ==="
# =========================================================
sync_dir  ".config/k9s"

# =========================================================
echo "=== htop ==="
# =========================================================
sync_file ".config/htop/htoprc"

# =========================================================
echo "=== Calibre ==="
# =========================================================
sync_file ".config/calibre/global.py.json"
sync_file ".config/calibre/gui.json"
sync_file ".config/calibre/gui.py.json"
sync_file ".config/calibre/tweak_book_gui.json"

# =========================================================
echo "=== IntelliJ IDEA ==="
# =========================================================
# Sync only keymaps, codestyles, and key options — not caches
IDEA_DIR=$(ls -d "$HOME"/.config/JetBrains/IntelliJIdea* 2>/dev/null | sort -V | tail -1 | sed "s|$HOME/||")
if [[ -n "$IDEA_DIR" ]]; then
  echo "  (latest: ~/$IDEA_DIR)"
  sync_dir  "$IDEA_DIR/keymaps"
  sync_dir  "$IDEA_DIR/codestyles"
  sync_dir  "$IDEA_DIR/colors"
  sync_file "$IDEA_DIR/idea64.vmoptions"
  sync_file "$IDEA_DIR/idea.properties"

  # Sync selected option files (not all — many are machine-specific)
  for opt in code.style.schemes.xml colors.scheme.xml editor.xml laf.xml ui.lnf.xml; do
    sync_file "$IDEA_DIR/options/$opt"
  done
else
  echo "  ✗ No IntelliJ IDEA config found"
fi

# =========================================================
echo "=== Certs ==="
# =========================================================
sync_dir "certs"

# =========================================================
echo ""
echo "All done. Remember to fix permissions on the target:"
echo "  chmod 700 ~/.ssh ~/.gnupg"
echo "  chmod 600 ~/.ssh/id_rsa ~/.pgpass ~/.git-credentials"
echo ""
