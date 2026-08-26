#!/usr/bin/env bash
# setup.sh — run this ONCE, from inside this folder, after you've:
#   1. created an empty GitHub repo (e.g. francais-moderne-site)
#   2. enabled Pages on it (Settings -> Pages -> Deploy from a branch -> main -> /(root))
#
# Usage:
#   ./setup.sh "your-chosen-password" "https://github.com/USERNAME/REPO.git"

set -euo pipefail

PASSWORD="${1:?Usage: ./setup.sh <password> <github-repo-url>}"
REPO_URL="${2:?Usage: ./setup.sh <password> <github-repo-url>}"

# 1. Compute the SHA-1 hash of the password (this becomes the content folder name)
HASH=$(printf '%s' "$PASSWORD" | shasum -a 1 | awk '{print $1}')
echo "== Password hash: $HASH =="

# 2. Rename the placeholder content folder to the real hash
if [ -d "PASSWORD_HASH_GOES_HERE" ]; then
  mv "PASSWORD_HASH_GOES_HERE" "$HASH"
  # keep .gitkeep so the empty folder is trackable by git until you add real files
  echo "== Renamed content folder to: $HASH =="
fi

# 3. Init git, connect to your GitHub repo, and push
git init -b main
git add .
git commit -m "Initial site setup"
git remote add origin "$REPO_URL"
git push -u origin main

echo ""
echo "== Done! =="
echo "Your password is:   $PASSWORD"
echo "Your content folder is:  $HASH/"
echo "Paste each week's files into that folder, then run publish_week.R to push updates."
