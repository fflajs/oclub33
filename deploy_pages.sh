#!/bin/bash
# ==========================================================
# deploy_pages.sh – Club33 (Cognos v3) GitHub Pages Deployer
# ==========================================================
# Version: 2025-10-15
# Author:  Flavio (Club33 project)
#
# Purpose:
#   Deploys the static Club33 web app directly from the `main`
#   branch to GitHub Pages (fflajs/oclub33).
#   Requires no build step, no gh-pages branch.
#
# Notes:
#   • Uses the current working tree (HTML + JS + data/ + docs)
#   • Safe: never deletes or overwrites main
#   • Optional: pre-deployment BACKUP.sh hook
# ==========================================================

set -e  # stop on first error

# --- CONFIGURATION -----------------------------------------------------------
REMOTE="fflajs"          # target GitHub remote
BRANCH="main"            # deployment branch
REPO_URL="https://fflajs.github.io/oclub33/"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# --- HEADER ------------------------------------------------------------------
echo "🚀 Deploying Club33 (Cognos v3) → GitHub Pages"
echo "📅 $DATE"
echo "📂 Remote: $REMOTE  |  Branch: $BRANCH"
echo "🌐 Target: $REPO_URL"
echo "-------------------------------------------------------------------"

# --- PRECHECKS ---------------------------------------------------------------
if [ ! -d .git ]; then
  echo "❌  Not a git repository. Run inside project root."
  exit 1
fi

# Confirm branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "$BRANCH" ]; then
  echo "❌  You are on branch '$CURRENT_BRANCH'. Please switch to '$BRANCH'."
  exit 1
fi

# Ensure .env is ignored
if [ -f .env ]; then
  echo "⚠️  Found local .env – ensuring it's in .gitignore ..."
  echo ".env" >> .gitignore
fi

# Optional backup hook
if [ -x ./BACKUP.sh ]; then
  echo "💾  Running local backup..."
  ./BACKUP.sh || echo "⚠️  Backup script returned non-zero status, continuing..."
fi

# --- GIT OPERATIONS ----------------------------------------------------------
echo "✅  Staging all changes..."
git add -A

echo "📝  Commit message:"
read -p "Enter message (default: 'Deploy static site to GitHub Pages'): " msg
msg=${msg:-"Deploy static site to GitHub Pages"}

git commit -m "$msg" || echo "ℹ️  No changes to commit."

echo "⬆️  Pushing to remote ($REMOTE/$BRANCH)..."
git push "$REMOTE" "$BRANCH"

# --- POST-DEPLOY INFO --------------------------------------------------------
echo ""
echo "✅  Deployment complete!"
echo "🕓  GitHub Pages rebuilds every few minutes."
echo "🔗  Check status at:"
echo "     $REPO_URL"
echo ""
echo "Tip:  If you ever switch back to gh-pages workflow, see Section 6 of DEPLOY_GITHUB.md."
echo "-------------------------------------------------------------------"

