# 🚀 DEPLOYMENT GUIDE – Club33 Cognitive Web App (Static Supabase Edition)

## 🧱 Environment Overview

| Component | Description |
|------------|-------------|
| **Server OS** | Ubuntu 22.04 LTS |
| **Web Server** | Apache 2.4 (with `cgid` enabled) |
| **Database** | Supabase PostgreSQL |
| **AI API** | Google Gemini via Bash CGI proxy |
| **Project Directory** | `/home/fla/REP/oclub33` |
| **Public URL** | [https://club33.mywire.org](https://club33.mywire.org) |

---

## 📦 1. Install Apache with CGI Support

```bash
sudo apt update
sudo apt install apache2
sudo a2enmod cgid
sudo systemctl restart apache2
Verify CGI module is active:

bash
Copy code
apachectl -M | grep cgid
🧩 2. Directory Layout
pgsql
Copy code
/home/fla/REP/oclub33/
 ├── data/
 │   ├── Deep_Analysis_120.json
 │   ├── Normal_Analysis_60.json
 │   ├── Pulse_Check_12.json
 │   └── voxel_data.csv
 ├── index.html
 ├── register.html
 ├── login.html
 ├── portal.html
 ├── admin.html
 ├── analysis.html
 ├── org-chart.html
 ├── iteration-manager.html
 ├── table-viewer.html
 ├── cognitive-tool.html
 ├── README.md
 ├── CHANGELOG.md
 ├── VERSION.txt
 └── .env
🔐 3. Environment Variables
File:

bash
Copy code
/home/fla/REP/oclub33/.env
Contents:

ini
Copy code
SUPABASE_URL=https://dtfecbqteajwtcmqudpd.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR0ZmVjYnF0ZWFqd3RjbXF1ZHBkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg3Mjc0MzksImV4cCI6MjA3NDMwMzQzOX0.tY8R92LdJuGMDI3kVA2nN3ALugSRP3LJKCMBuVm7vRY
GEMINI_API_KEY=your-google-api-key-here
Set permissions:

bash
Copy code
sudo chown root:www-data /home/fla/REP/oclub33/.env
sudo chmod 640 /home/fla/REP/oclub33/.env
sudo chmod 711 /home/fla
🧠 4. Configure Gemini Proxy
File:

swift
Copy code
/usr/lib/cgi-bin/gemini-proxy.sh
Example content:

bash
Copy code
#!/bin/bash
echo "Content-Type: application/json"
echo ""

ENV_FILE="/home/fla/REP/oclub33/.env"
if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
else
  echo '{"error":"Missing .env file"}'
  exit 1
fi

read -r BODY
TEXT=$(echo "$BODY" | sed -E 's/.*"text":"([^"]+)".*/\1/')

if [ -z "$GEMINI_API_KEY" ]; then
  echo '{"error":"Missing GEMINI_API_KEY"}'
  exit 1
fi

curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "x-goog-api-key: ${GEMINI_API_KEY}" \
  -d "{\"contents\":[{\"parts\":[{\"text\":\"${TEXT}\"}]}]}" \
  "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent"
Set permissions:

bash
Copy code
sudo chmod 755 /usr/lib/cgi-bin/gemini-proxy.sh
Test it:

bash
Copy code
curl -X POST -H "Content-Type: application/json" \
  -d '{"text":"Hello from Flavio"}' \
  https://club33.mywire.org/cgi-bin/gemini-proxy.sh
🌐 5. Apache Configuration
File:

bash
Copy code
/etc/apache2/sites-enabled/oclub33.conf
Example:

apache
Copy code
<VirtualHost *:443>
    ServerName club33.mywire.org
    DocumentRoot /home/fla/REP/oclub33

    <Directory /home/fla/REP/oclub33>
        AllowOverride All
        Require all granted
    </Directory>

    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
    <Directory "/usr/lib/cgi-bin">
        AllowOverride None
        Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
        Require all granted
    </Directory>

    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/club33.mywire.org/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/club33.mywire.org/privkey.pem
    Include /etc/letsencrypt/options-ssl-apache.conf
</VirtualHost>
Restart:

bash
Copy code
sudo systemctl restart apache2
🧩 6. Supabase Database
Supabase project: dtfecbqteajwtcmqudpd

Required tables:

people

organization_units

person_roles

iterations

app_data

surveys

Ensure anon role has read/write permissions where required.

🧠 7. Testing Procedure
Open browser console → F12

Visit:

https://club33.mywire.org/index.html

Register a user (not "Admin")

Login → Redirects to portal → Cognitive Visualizer

Check for:

✅ Supabase client initialized

✅ active iteration loaded

✅ gemini-proxy.sh response

🏁 8. GitHub and Version Control
Push working version:

bash
Copy code
git add .
git commit -m "Deploy static Supabase version (Cognos v3)"
git push fflajs main
Tag stable release:

bash
Copy code
git tag -a stable-v3 -m "Stable Apache static Supabase version"
git push fflajs main --tags
🔮 Future Deployment Options
Option	Description
Supabase Edge Function	Move Gemini logic to Supabase (no Apache needed)
Vercel / GitHub Pages	Host static HTML, keep Gemini proxy external
Docker Image	Bundle Apache + CGI + HTML into one container

✅ Verification Checklist
Item	Status
Supabase connection	✅ OK
Gemini proxy	✅ OK
Data files in /data	✅ OK
HTML layout preserved	✅ OK
Iteration cloning	✅ OK
Version tracking	✅ OK (VERSION.txt)

📧 Email Notifications (Gmail + msmtp Integration)
Overview

Your Club33 static-Supabase app can now send e-mail notifications directly from the server (e.g., for nightly backups or system alerts).
Mail delivery is handled by msmtp, using your Gmail account with an App Password for secure authentication.

1️⃣ Install and link msmtp
sudo apt update
sudo apt install -y msmtp msmtp-mta bsd-mailx
sudo ln -sf /usr/bin/msmtp /usr/sbin/sendmail

2️⃣ Create /etc/msmtprc (system-wide) or ~/.msmtprc (user-level)
# ~/.msmtprc
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        /var/log/msmtp.log

account gmail
host smtp.gmail.com
port 587
from fla4all@gmail.com
user fla4all@gmail.com
password YOUR_16_CHARACTER_APP_PASSWORD
tls_starttls on

account default : gmail


Permissions:

chmod 600 ~/.msmtprc
chown $USER:$USER ~/.msmtprc

3️⃣ Generate a Gmail App Password

Go to https://myaccount.google.com/apppasswords

Choose Mail → Other (Custom name) → “msmtp”

Copy the 16-character password (no spaces) and paste it into password.

4️⃣ Test the setup
echo "Club33 test mail from $(hostname)" | mail -s "Club33 notification test" fflajs@gmail.com
sudo tail -n 10 /var/log/msmtp.log


✅ Expect exitcode=EX_OK and an incoming message.

5️⃣ Use in cron jobs
0 3 * * * /home/fla/REP/oclub33/scripts/backup.sh \
    && echo "Club33 backup OK $(date)" | mail -s "Club33 backup OK" fflajs@gmail.com \
    || echo "Club33 backup FAILED $(date)" | mail -s "Club33 backup FAILED" fflajs@gmail.com

6️⃣ Troubleshooting

View msmtp logs:
sudo tail -n 50 /var/log/msmtp.log

Check Gmail “Sent” folder.

If you see “Application-specific password required,” re-generate the App Password.

Author: Flavio
Project: Club33 Cognitive Web App
Version: Cognos v3 (Static Supabase Edition)
Date: 2025-10-14
Status: Production Ready ✅
