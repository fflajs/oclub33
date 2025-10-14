# 🧭 SUMMARY – Club33 Cognitive Web App

## 💡 Project Overview
**Name:** Club33 Cognitive Web App  
**Version:** Cognos v3 – Static Supabase Edition  
**Author:** Flavio (Vienna)  
**Repository:** [fflajs/oclub33](https://github.com/fflajs/oclub33)  
**Deployment Target:** Apache Server (`https://club33.mywire.org`)  

---

## ⚙️ Architecture
- 100% **static HTML + JavaScript** frontend  
- Uses **Supabase** for database and authentication  
- Uses **Apache CGI script** for Gemini API access  
- Stores question sets and voxel data under `/data/`  
- No Node.js, Express, or serverless functions required  

---

## 🧱 Directory Layout
oclub33/
├── data/
│ ├── Deep_Analysis_120.json
│ ├── Normal_Analysis_60.json
│ ├── Pulse_Check_12.json
│ └── voxel_data.csv
├── index.html
├── register.html
├── login.html
├── portal.html
├── analysis.html
├── admin.html
├── org-chart.html
├── iteration-manager.html
├── table-viewer.html
├── cognitive-tool.html
├── README.md
├── CHANGELOG.md
├── DEPLOY.md
├── VERSION.txt
└── .env

yaml
Copy code

---

## 🧩 Main Application Flow

| Step | File | Description |
|------|------|-------------|
| 1️⃣ | `index.html` | Welcome screen |
| 2️⃣ | `register.html` | New user registration (no Admin allowed) |
| 3️⃣ | `login.html` | User + role + iteration selection |
| 4️⃣ | `portal.html` | Displays active iteration and app entry points |
| 5️⃣ | `cognitive-tool.html` | Visualization core (CSV + Gemini + Supabase) |
| 6️⃣ | `analysis.html` | AI text analysis via Gemini proxy |
| 7️⃣ | `admin.html` | Supabase-based admin dashboard |
| 8️⃣ | `org-chart.html` | Org management and people-role assignment |
| 9️⃣ | `iteration-manager.html` | Create / clone / close iterations |
| 🔟 | `table-viewer.html` | Direct Supabase table data viewer |

---

## 🧠 Technology Stack

| Layer | Component |
|-------|------------|
| **Frontend** | HTML + TailwindCSS + Vanilla JS |
| **Backend** | Supabase PostgreSQL |
| **AI Integration** | Gemini via Bash CGI (`gemini-proxy.sh`) |
| **Web Server** | Apache2 (mod_cgid enabled) |
| **Environment** | `.env` (for Supabase & Gemini keys) |

---

## 🧾 Documentation Index

| File | Purpose |
|------|----------|
| `README.md` | General overview and introduction |
| `CHANGELOG.md` | Full history of project versions |
| `DEPLOY.md` | Step-by-step server + Supabase deployment guide |
| `VERSION.txt` | Version tag and build date |
| `SUMMARY.md` | Quick overview of architecture and flow |

---

## ✅ Current Status
| Area | Status |
|------|---------|
| Apache + CGI | ✅ Working |
| Supabase DB | ✅ Connected |
| Gemini proxy | ✅ Responding |
| Data files | ✅ Accessible |
| All HTML pages | ✅ Functional |
| Layout preservation | ✅ True to original |
| Conversion complete | ✅ 100% static version deployed |

---

## 🔮 Next Steps
- Deploy on Supabase Edge Functions or Vercel (optional)
- Add mobile-responsive layout polish
- Bundle static assets with Tailwind build (CLI/PostCSS)
- Optionally migrate Gemini CGI to TypeScript Edge Function

---

**Cognos v3 — Static Supabase Edition**  
© 2025 Flavio • Vienna  
