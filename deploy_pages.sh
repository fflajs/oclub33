#!/bin/bash
# ============================================================
#  DEPLOY_PAGES.SH
#  Deploys Club33 static frontend (HTML + data) to GitHub Pages
#  Author: Flavio (Vienna)
#  Version: 1.0
#  Updated: 2025-10-14
#
#  Description:
#   - Ensures all changes are committed to main first
#   - Creates or updates gh-pages branch with only web-visible files
#   - Pushes gh-pages branch to GitHub (fflajs/oclub33)
#   - Does NOT touch the main branch contents
# ============================================================

set -e

REPO_DIR="/home/fla/REP/oclub33"
REPO_REMOTE="fflajs"
PUBLIC_FILES="*.html data README.md DEPLOY.md DEPLOY_GITHUB.md SUMMARY.md BACKUP.md VERSION.txt"
BRANCH_MAIN="main"
BRANCH_PAGES="gh-pages"

cd "$REPO_DIR"

echo "--------------------------------------------"
echo "🧠 Club33 GitHub Pages Deployment"
echo "--------------------------------------------"
echo "Repository: $REPO_DIR"
echo "Remote: $REPO_REMOTE"
echo

# ---- Ensure we are on main and up-to-date ----
echo "Checking current branch..."
CURRENT_BRANCH=$(git branch --show-current)

if [ "$CURRENT_BRANCH" != "$BRANCH_MAIN" ]; then
  echo "❌ Please switch to '$BRANCH_MAIN' branch first!"
  exit 1
fi

echo "Pulling latest changes from remote..."
git pull --ff-only "$REPO_REMOTE" "$BRANCH_MAIN"

# ---- Confirm everything is committed ----
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "⚠️ Uncommitted changes detected. Commit them first:"
  echo "   git add -A && git commit -m 'Save before deploy'"
  exit 1
fi

# ---- Create or reset gh-pages branch ----
echo
echo "Creating or updating branch '$BRANCH_PAGES'..."
git checkout "$BRANCH_PAGES" 2>/dev/null || git checkout --orphan "$BRANCH_PAGES"

# Remove old contents
git rm -rf . >/dev/null 2>&1 || true

# ---- Copy files to deploy ----
echo "Copying public files..."
for f in $PUBLIC_FILES; do
  cp -r $f . 2>/dev/null || echo "Skipping missing: $f"
done

# ---- Commit and push ----
git add -A
git commit -m "Deploy static frontend to GitHub Pages ($(date +'%Y-%m-%d %H:%M'))" || echo "No changes to commit."

echo "Pushing to remote branch '$BRANCH_PAGES'..."
git push -f "$REPO_REMOTE" "$BRANCH_PAGES"

# ---- Return to main branch ----
git checkout "$BRANCH_MAIN"

echo
echo "✅ Deployment complete!"
echo "--------------------------------------------"
echo "Now enable GitHub Pages in Settings → Pages:"
echo "Source: gh-pages branch"
echo "URL: https://$REPO_REMOTE.github.io/oclub33/"
echo "--------------------------------------------"

