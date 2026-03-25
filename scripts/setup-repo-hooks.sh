#!/usr/bin/env bash
#
# setup-repo-hooks.sh -- Install secret-scanning pre-commit hook
#
# Usage: Run from inside any git repo:
#   ~/.config/dotfiles/scripts/setup-repo-hooks.sh
#
# What it does:
#   1. Verifies you're in a git repo
#   2. Installs (symlinks) the pre-commit-secrets hook
#   3. Creates a .secretsignore template if one doesn't exist
#
# The hook is symlinked so updates to the source propagate everywhere.

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
RESET='\033[0m'

HOOK_SOURCE="$HOME/.config/dotfiles/scripts/pre-commit-secrets"
HOOK_DIR=".git/hooks"
HOOK_TARGET="$HOOK_DIR/pre-commit"

# ── Verify git repo ──────────────────────────────────────────────────
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo -e "${RED}Error:${RESET} Not inside a git repository."
  exit 1
fi

REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

echo -e "${BOLD}Setting up secret-scanning hooks for:${RESET} $REPO_ROOT"

# ── Verify hook source exists ────────────────────────────────────────
if [[ ! -x "$HOOK_SOURCE" ]]; then
  echo -e "${RED}Error:${RESET} Hook source not found at $HOOK_SOURCE"
  echo "  Make sure dotfiles are set up first."
  exit 1
fi

# ── Install pre-commit hook ──────────────────────────────────────────
if [[ -f "$HOOK_TARGET" ]] || [[ -L "$HOOK_TARGET" ]]; then
  existing=$(readlink -f "$HOOK_TARGET" 2>/dev/null || echo "$HOOK_TARGET")
  if [[ "$existing" == "$(readlink -f "$HOOK_SOURCE")" ]]; then
    echo -e "${GREEN}Hook already installed${RESET} (symlinked to dotfiles)."
  else
    echo -e "${YELLOW}Warning:${RESET} Existing pre-commit hook found at $HOOK_TARGET"
    echo "  Current target: $existing"
    read -p "  Replace it? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm "$HOOK_TARGET"
      ln -s "$HOOK_SOURCE" "$HOOK_TARGET"
      echo -e "${GREEN}Hook replaced${RESET} with symlink to dotfiles."
    else
      echo "  Skipping hook install."
    fi
  fi
else
  mkdir -p "$HOOK_DIR"
  ln -s "$HOOK_SOURCE" "$HOOK_TARGET"
  echo -e "${GREEN}Hook installed${RESET} (symlinked to dotfiles)."
fi

# ── Create .secretsignore template ───────────────────────────────────
IGNORE_FILE="$REPO_ROOT/.secretsignore"
if [[ ! -f "$IGNORE_FILE" ]]; then
  cat > "$IGNORE_FILE" << 'TEMPLATE'
# .secretsignore -- Patterns to exclude from secret scanning
#
# One regex per line. Lines starting with # are comments.
# Matched against the full line of each finding.
#
# Examples:
# EXAMPLE_KEY          # ignore lines containing EXAMPLE_KEY
# test_.*_key          # ignore test keys
# \.md$                # ignore all markdown files (matched against filename)
TEMPLATE
  echo -e "${GREEN}Created${RESET} .secretsignore template."
  echo "  Add it to .gitignore or commit it -- your choice."
else
  echo -e "${GREEN}.secretsignore${RESET} already exists."
fi

echo ""
echo -e "${GREEN}${BOLD}Done.${RESET} The pre-commit hook will scan for secrets on every commit."
echo "  Bypass with: git commit --no-verify"
