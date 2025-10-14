# 🧾 CHANGELOG – Club33 Cognitive Web App

## 📘 Version: Cognos v3 (Static Supabase)
**Date:** 2025-10-14  
**Status:** Stable / Deployed on Apache (`club33.mywire.org`)

### ✨ Major Milestone – Node.js → 100 % Static Supabase
- Complete removal of `server.js`, `express`, and `api/admin/[action].js`
- All dynamic features rewritten in pure HTML + JavaScript with direct Supabase client queries
- Project now runs as a fully static web app under Apache or any static host

---

### 🧠 Core Functional Changes
| Area | Transformation |
|------|----------------|
| **Supabase Integration** | Direct `@supabase/supabase-js` calls for auth + DB access (no Node APIs) |
| **Gemini Integration** | New CGI bridge (`/usr/lib/cgi-bin/gemini-proxy.sh`) replaces Node endpoint |
| **Environment Handling** | `.env` now used by CGI script on Apache for secure API keys |
| **Static Hosting** | App runs entirely from `/home/fla/REP/oclub33` on Apache |
| **Data Loading** | All JSON/CSV resources fetched directly from `/data` |
| **Supabase Edge Function Ready** | `gemini-proxy.sh` can be migrated to Supabase Edge Function later |

---

### 💡 Converted HTML Modules
| File | Key Enhancements |
|------|------------------|
| `index.html` | Welcome screen; simplified text; no server dependency |
| `register.html` | Client-side validation; “Admin” name reserved; Supabase insert |
| `login.html` | Iteration-aware login with role dropdown; Supabase query |
| `portal.html` | Dynamic “Welcome <user>” and active iteration from Supabase |
| `analysis.html` | Gemini integration via CGI; summary and aggregated text areas |
| `admin.html` | Unified Supabase admin dashboard (no Node) |
| `org-chart.html` | Full hierarchical view preserved; roles + people assignments working |
| `iteration-manager.html` | Iteration creation (clone + blank); Supabase transactions |
| `table-viewer.html` | Displays all tables via Supabase queries |
| `cognitive-tool.html` | Static Cognition Visualizer with Supabase + Gemini + local CSV/JSON |

---

### 🧩 Supporting Files
- `/data/Deep_Analysis_120.json`, `Normal_Analysis_60.json`, `Pulse_Check_12.json` – question sets  
- `/data/voxel_data.csv` – cognitive mapping dataset  
- `.env` – used only by Apache CGI for private keys  
- `/usr/lib/cgi-bin/gemini-proxy.sh` – Gemini API bridge script  

---

### ⚙️ System Integration and Testing
- Apache `cgid` module enabled (`sudo a2enmod cgid`)
- Verified `.env` read permissions and directory execution rights
- All functional tests passed ✅  
  - Cognitive Tool loaded CSV + JSON + Gemini  
  - Register / Login / Portal / Analysis / Org-Chart / Iteration Manager / Table Viewer functional  

---

### 🔒 Security Improvements
- No API keys embedded in HTML; Gemini key read via CGI only  
- “Admin” username restricted (case-insensitive)  
- Supabase Anon Key used read-only; writes controlled per table policy  

---

### 🗃️ Version History
| Version | Date | Description |
|----------|------|-------------|
| **Org Manager v1** | 2025-10-04 | Stable Node.js Org Manager |
| **Cognos v2** | 2025-10-05 | Active Iteration Context Stable |
| **Cognos v3 (Static)** | 2025-10-14 | Full static Supabase version; Node.js removed |

---

### 🏁 Next Steps
- ✅ Phase 1 – Static conversion (on Apache) ✔️ **Done**
- 🧠 Phase 2 – Move `gemini-proxy.sh` to Supabase Edge Function 
- ☁️ Phase 3 – Migrate hosting to Supabase Storage or Vercel 
- 🎨 Phase 4 – Optimize layout and UX for mobile devices 

---

**Author:** Flavio  
**Repository:** `fflajs/oclub33`  
**Maintainer:** Flavio (Vienna)  
**License:** Internal Development Use Only  

