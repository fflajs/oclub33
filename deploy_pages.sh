#!/bin/bash
# =======================================================
# deploy_pages.sh – Deploy Club33 (Cognos v3) to GitHub Pages
# =======================================================

set -e  # stop on first error

# --- CONFIG ---
REPO="fflajs/oclub33"
BRANCH="main"
BUILD_DIR="."
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "🚀 Deploying Club33 (Cognos v3) to GitHub Pages"
echo "📅 $DATE"

# --- PRECHECKS ---
if [ ! -d .git ]; then
  echo "❌ Not a git repository. Please run inside project root."
  exit 1
fi

if [ -f .env ]; then
  echo "⚠️  Local .env found — ensuring it's excluded from commit..."
  echo ".env" >> .gitignore
fi

# --- COMMIT & PUSH ---
echo "✅ Adding all changes..."
git add -A

echo "📝 Commit message:"
read -p "Enter message (default: 'Deploy static site to GitHub Pages'): " msg
msg=${msg:-"Deploy static site to GitHub Pages"}

git commit -m "$msg" || echo "ℹ️  No changes to commit"

echo "⬆️  Pushing to GitHub..."
git push origin "$BRANCH"

# --- CONFIRM DEPLOYMENT ---
echo ""
echo "🌐 Visit your site after a few minutes at:"
echo "👉 https://$REPO.github.io/"
echo ""
echo "✅ Done. GitHub Pages will build automatically from branch: $BRANCH"

