DEPLOY_GITHUB.md
Overview

This repo hosts the static frontend of Club33 (HTML + JS + Tailwind CDN + Supabase client).
You have two deployment modes:

GitHub Pages (Static Only)

Serves HTML/JS/CSS + /data/* files directly from GitHub.

Supabase is called from the browser (no server).

Gemini text analysis is NOT available (no CGI on GitHub Pages).

Hybrid: GitHub Pages + Gemini CGI Proxy

Frontend on GitHub Pages for speed & simplicity.

Gemini requests go to your existing Apache CGI endpoint:
https://club33.mywire.org/cgi-bin/gemini-proxy.sh

Everything else (Supabase, data files) stays static.

Prerequisites

Repo: fflajs/oclub33

Folder on server: /home/fla/REP/oclub33

Files to deploy: all HTML pages and the data/ directory (CSV/JSON)

Supabase anon key & URL are embedded in the HTML (already done)

For Hybrid: your Apache CGI is already working

1) GitHub Pages (Static Only)
1.1 Create a gh-pages branch with just the web assets

From your server:

cd /home/fla/REP/oclub33

# Start a fresh gh-pages branch without history
git checkout --orphan gh-pages

# Remove everything from git index (keeps working tree)
git rm -rf .

# Copy required files into repo root for Pages
# (Put your HTML files + data/ in the root)
cp -a index.html portal.html login.html register.html cognitive-tool.html \
      analysis.html admin.html org-chart.html iteration-manager.html table-viewer.html \
      data ./

# Optional: add docs too (README.md, DEPLOY.md, SUMMARY.md, BACKUP.md)
cp -a README.md DEPLOY.md SUMMARY.md BACKUP.md . 2>/dev/null || true

# Commit & push
git add .
git commit -m "Deploy static frontend to GitHub Pages"
git push -u fflajs gh-pages


Notes

Use relative links in your HTML (already done).

Paths like href="login.html" and fetch('data/voxel_data.csv') will resolve under https://fflajs.github.io/oclub33/.

1.2 Enable GitHub Pages

Open: https://github.com/fflajs/oclub33/settings/pages

Source → Select gh-pages branch

Save

Your site will appear shortly at:

https://fflajs.github.io/oclub33/

1.3 CORS for Supabase (usually fine)

Supabase accepts browser calls by default with anon key. If you use Row Level Security/policies that restrict origins, add https://fflajs.github.io as an allowed origin in Supabase Auth → URL config / Allowed Redirect URLs (not strictly required for anon usage, but good hygiene).

2) Hybrid: GitHub Pages + Gemini CGI Proxy

If you want Gemini analysis to work while hosting the frontend on GitHub Pages, you’ll call your existing CGI endpoint on your server.

2.1 Configure the Gemini proxy URL in your frontend

In the page(s) that call Gemini (e.g., analysis.html), set the proxy like this (you already have this pattern in recent versions):

<script>
  const GEMINI_PROXY_URL = 'https://club33.mywire.org/cgi-bin/gemini-proxy.sh';

  async function analyzeText(text) {
    const resp = await fetch(GEMINI_PROXY_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ text })
    });
    if (!resp.ok) throw new Error('Gemini proxy error');
    return await resp.json();
  }
</script>


This keeps your CGI on Apache, while GitHub Pages serves the UI and /data/* static files.

2.2 CORS (if needed)

If the browser complains about CORS when calling the CGI, add this header in your CGI output (first lines of your bash script):

echo "Access-Control-Allow-Origin: https://fflajs.github.io"
echo "Access-Control-Allow-Headers: Content-Type"
echo "Access-Control-Allow-Methods: POST, OPTIONS"
if [ "$REQUEST_METHOD" = "OPTIONS" ]; then
  echo ""
  exit 0
fi
echo "Content-Type: application/json"
echo ""


(Your earlier script already prints Content-Type. You can prepend the CORS lines.)

3) Keeping Pages Updated

When you make changes on main, just re-export to gh-pages:

# From main branch
git checkout main
git pull --ff-only

# Recreate gh-pages with fresh files
git checkout gh-pages
git rm -rf .
git checkout main -- index.html portal.html login.html register.html \
  cognitive-tool.html analysis.html admin.html org-chart.html iteration-manager.html table-viewer.html data \
  README.md DEPLOY.md SUMMARY.md BACKUP.md 2>/dev/null || true

git add .
git commit -m "Update GitHub Pages deployment"
git push


(If you prefer, you can keep a simple script deploy_pages.sh that does this.)

4) Troubleshooting

Broken links: Ensure all links are relative (href="login.html") and not absolute (/login.html).

Data 404: Confirm data/ exists on the gh-pages branch and contains the CSV/JSON.

Gemini failing:

Ensure GEMINI_PROXY_URL is absolute to your domain

Add CORS headers in CGI (see 2.2)

Check Apache logs on club33.mywire.org

Supabase errors: verify anon key + URL in the HTML match your project.

5) What lives where?

GitHub Pages: All HTML/JS + data/ + docs → https://fflajs.github.io/oclub33/

Apache (your server): /cgi-bin/gemini-proxy.sh (Gemini only)

Supabase: database + REST/JS client
