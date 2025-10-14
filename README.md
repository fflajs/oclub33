# 🧭 Club33 Cognitive Web App (Static Supabase Version)

## 📌 Overview
**Club33** is a fully static cognitive and organizational visualization platform.  
It uses **Supabase** as its backend (database + authentication + serverless functions)**  
and requires **no Node.js** or backend servers.

This version (v3) marks the complete transition from a Node.js + Express app  
to a **100% static HTML + JS frontend** that interacts directly with Supabase.

---

## 🏗️ Architecture

| Component | Description |
|------------|-------------|
| **HTML/JS Frontend** | Runs entirely client-side, hosted on Apache or any static web host |
| **Supabase Database** | Stores all app data: iterations, org units, people, surveys, etc. |
| **Gemini Proxy (CGI)** | Temporary Bash script on Apache to access Google Gemini API |
| **Optional Supabase Edge Function** | Portable JS replacement for `gemini-proxy.sh` |
| **Data Files** | JSON and CSV files in `/data/` for analysis and visualization |

---

## 🧩 Core Files

| File | Purpose |
|------|----------|
| `index.html` | Entry page / welcome screen |
| `register.html` | User registration |
| `login.html` | Login with iteration-based role selector |
| `portal.html` | Entry hub (Cognitive Visualizer or Analysis) |
| `analysis.html` | Gemini-powered text analysis |
| `admin.html` | Admin dashboard |
| `org-chart.html` | Organization structure management |
| `iteration-manager.html` | Iteration lifecycle management |
| `table-viewer.html` | Debug view of all database tables |
| `cognitive-tool.html` | Core cognitive visualization engine |
| `data/*.json` | Question sets and analysis templates |
| `data/voxel_data.csv` | Cognitive 3D mapping data |
| `.env` | Local server configuration (for Apache CGI only) |

---

## ⚙️ Hosting Options

### ✅ Apache (Recommended now)
Keep your current setup:
- Static HTML files in `/home/fla/REP/oclub33/`
- CGI Gemini proxy at `/usr/lib/cgi-bin/gemini-proxy.sh`
- `.env` file stores GEMINI_API_KEY

### 🌐 GitHub / Vercel (Optional future)
- Remove CGI dependency
- Deploy Supabase Edge Function (`gemini-proxy`)
- Update HTMLs to use the new function URL

---

## 🚀 Deploying to GitHub

```bash
cd ~/REP/oclub33
git add .
git commit -m "Static Supabase version - Node.js fully removed (Cognos v3)"
git push fflajs main
git tag -a static-v1 -m "Full static conversion completed"
git push fflajs static-v1

