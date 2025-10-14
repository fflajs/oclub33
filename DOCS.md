# 🧠 Developer Documentation – Club33 Cognitive Web App (Cognos v3)

## 📘 Overview

**Edition:** Static Supabase + Apache CGI  
**Author:** Flavio (Vienna)  
**Version:** Cognos v3 (Static Supabase Edition)  
**Date:** 2025-10-14  
**Repository:** [fflajs/oclub33](https://github.com/fflajs/oclub33)

This document describes:
- Database schema and relationships
- Supabase query patterns used across HTML files
- Gemini API integration via Bash CGI
- Application logic and data flow
- Frontend module responsibilities

---

## 🧩 Database Schema (Supabase PostgreSQL)

| Table | Description | Key Fields |
|--------|--------------|------------|
| **people** | Stores all registered users | `id`, `name`, `created_at` |
| **organization_units** | Hierarchical structure of units | `id`, `name`, `parent_id`, `iteration_id` |
| **person_roles** | Links a person to a role in a unit | `id`, `person_id`, `unit_id`, `role`, `iteration_id` |
| **iterations** | Project iterations / cycles | `id`, `name`, `start_date`, `end_date`, `question_set` |
| **app_data** | Generic storage (JSON or config data) | `id`, `key`, `value` |
| **surveys** | Stores cognitive question responses | `id`, `person_role_id`, `iteration_id`, `answers` (JSON) |

### Relationships
- `person_roles.person_id → people.id`
- `person_roles.unit_id → organization_units.id`
- `organization_units.iteration_id → iterations.id`
- `surveys.iteration_id → iterations.id`

---

## 🔌 Supabase Client Setup

Every HTML page that interacts with the database initializes Supabase like this:

```js
const SUPABASE_URL = "https://dtfecbqteajwtcmqudpd.supabase.co";
const SUPABASE_ANON_KEY = "your-anon-key-here";
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
📂 Core HTML Modules
🟢 index.html
Welcome and introduction.

Links to Register or Portal.

Purely static (no Supabase).

🟢 register.html
Inserts a new user into people table.

Prevents duplicates and blocks “Admin” username (case-insensitive).

Stores loggedInUser in sessionStorage after success.

js
Copy code
const { data, error } = await supabase
  .from('people')
  .select('*')
  .eq('name', name);
if (data.length) alert('already registered');
else await supabase.from('people').insert([{ name }]);
🟢 login.html
Allows user selection and role from Supabase tables.

Displays available roles via:

js
Copy code
supabase.from('person_roles').select('*').eq('person_id', person.id)
Once selected, redirects to portal.html with sessionStorage.loggedInUser.

🟢 portal.html
Fetches active iteration from Supabase:

js
Copy code
supabase.from('iterations').select('*').is('end_date', null).single()
Displays greeting and two navigation links:

Cognitive Visualizer → login.html

Analyze Descriptions → analysis.html

🟢 analysis.html
Provides AI-driven text summarization and aggregation.

Calls /cgi-bin/gemini-proxy.sh via fetch():

js
Copy code
fetch('/cgi-bin/gemini-proxy.sh', {
  method: 'POST',
  headers: {'Content-Type':'application/json'},
  body: JSON.stringify({ text: userInput })
})
Displays output in <textarea id="summary-text"> and <textarea id="aggregated-text">.

🟢 admin.html
Reads and writes directly to all Supabase tables.

Allows inspection, addition, or deletion of data entries.

Uses table <select> and dynamic HTML forms.

Supabase query pattern:

js
Copy code
const { data } = await supabase.from(selectedTable).select('*');
🟢 org-chart.html
Visualizes the organizational hierarchy.

Loads all units, people, and roles:

js
Copy code
const { data: units } = await supabase.from('organization_units').select('*');
const { data: people } = await supabase.from('people').select('*');
const { data: roles } = await supabase.from('person_roles').select('*');
Uses recursion to render tree structure.

Allows inline creation/deletion of units and assigning/removing people.

Assign-person uses modal popup connected to Supabase inserts:

js
Copy code
supabase.from('person_roles').insert([{ person_id, unit_id, role, iteration_id }]);
🟢 iteration-manager.html
Displays and manages project iterations.

Detects the active iteration:

js
Copy code
const { data } = await supabase.from('iterations').select('*').is('end_date', null);
Supports:

Create Blank Iteration → Inserts new row with null end_date.

Clone From Active → Copies data from active iteration (org units + roles).

Close Active Iteration → Sets end_date = now().

🟢 table-viewer.html
Provides unified data inspection across all 6 main tables.

Uses <select> dropdown to choose the table.

Renders rows dynamically as formatted <table>.

🟢 cognitive-tool.html
Central visualization module.

Loads:

/data/voxel_data.csv

/data/<question_set>.json (from iteration)

Fetches user/role context from Supabase.

Sends text to Gemini via /cgi-bin/gemini-proxy.sh.

Renders 3D cognitive map (future: WebGL/Three.js).

⚙️ Gemini Proxy Integration
File: /usr/lib/cgi-bin/gemini-proxy.sh
Purpose: Acts as a lightweight server-side bridge between the frontend and Gemini API.

Request Flow:

HTML sends a POST with JSON:

json
Copy code
{"text":"Hello from Cognitive Tool"}
The CGI script reads .env, extracts the key, and calls:

bash
Copy code
https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent
The Gemini API returns JSON → echoed directly to the frontend.

🔐 Security and Access Notes
.env is owned by root:www-data and readable by the CGI process only.

Supabase key is anon key → safe for client-side use.

Only Gemini key is hidden server-side.

CGI proxy filters simple text only (no prompt injection handling yet — consider adding sanitization).

🧠 Debugging Conventions
Every major HTML page includes console tracing:

✅ Initialization messages

🟢 Success flow markers

🔴 Error markers with details

Example:

js
Copy code
console.log('→ querying Supabase for active iteration...');
console.log('✅ active iteration loaded:', data);
console.error('❌ Supabase error:', error);
🧩 Development Guidelines
Preserve layout when modifying — use Tailwind for any visual change.

Keep Supabase queries client-side and async.

Never call /api/... routes — all logic now client-driven.

If extending Gemini: duplicate gemini-proxy.sh or add endpoint logic (e.g., summarization vs. reasoning modes).

All paths are relative — /data/, /cgi-bin/, and static .html served directly by Apache.

🧾 Version Tracking
VERSION.txt → version + build info

CHANGELOG.md → version history

README.md → introduction

DEPLOY.md → server setup guide

SUMMARY.md → system overview

DOCS.md → (this file) developer reference

✅ Maintenance Checklist
Task	Recommended Interval
Supabase schema review	Monthly
Gemini key rotation	Every 90 days
Apache config audit	Quarterly
Data backup (data/)	Weekly
GitHub push & tag	After each major change

End of Document

Cognos v3 • Club33 Cognitive Web App
© 2025 Flavio • Vienna
