# 🧰 MAINTENANCE GUIDE – Club33 Cognitive Web App (Cognos v3)

**Version:** Cognos v3 – Static Supabase Edition  
**Author:** Flavio (Vienna)  
**Repository:** [fflajs/oclub33](https://github.com/fflajs/oclub33)  
**Server:** Ubuntu 22.04 + Apache + CGI  
**Database:** Supabase (PostgreSQL)  
**AI API:** Gemini (via `gemini-proxy.sh`)

---

## 🩺 1. System Health Checks

### 🧩 Apache Service
Check status:
```bash
sudo systemctl status apache2
Restart if needed:

bash
Copy code
sudo systemctl restart apache2
Reload after config change:

bash
Copy code
sudo systemctl reload apache2
List enabled modules:

bash
Copy code
apachectl -M | grep cgid
🌐 Supabase Connectivity
Verify that the anon key and URL are correct:

bash
Copy code
grep SUPABASE_URL /home/fla/REP/oclub33/.env
grep SUPABASE_ANON_KEY /home/fla/REP/oclub33/.env
Quick connection test:

bash
Copy code
curl -s https://dtfecbqteajwtcmqudpd.supabase.co/rest/v1/people \
  -H "apikey: $(grep SUPABASE_ANON_KEY /home/fla/REP/oclub33/.env | cut -d= -f2)" \
  -H "Authorization: Bearer $(grep SUPABASE_ANON_KEY /home/fla/REP/oclub33/.env | cut -d= -f2)"
You should get a JSON list of people (even if empty).

🧠 2. Gemini Proxy Monitoring
Test the proxy manually
bash
Copy code
curl -X POST -H "Content-Type: application/json" \
  -d '{"text":"Hello from maintenance test"}' \
  https://club33.mywire.org/cgi-bin/gemini-proxy.sh
Expected response:

json
Copy code
{"candidates":[{"content":{"parts":[{"text":"Hello!"}]}}]}
Logs (if proxy fails)
Check Apache’s error log:

bash
Copy code
sudo tail -n 30 /var/log/apache2/oclub33-error.log
If .env cannot be read:

bash
Copy code
sudo chmod 711 /home/fla
sudo chmod 640 /home/fla/REP/oclub33/.env
sudo chown root:www-data /home/fla/REP/oclub33/.env
🧹 3. Log Management
Apache logs:

lua
Copy code
/var/log/apache2/oclub33-access.log
/var/log/apache2/oclub33-error.log
Rotate logs manually:

bash
Copy code
sudo logrotate -f /etc/logrotate.conf
Or view live:

bash
Copy code
sudo tail -f /var/log/apache2/oclub33-error.log
🧾 4. Backup and Restore
Backup HTML + Data
Run weekly:

bash
Copy code
cd /home/fla/REP
tar czf oclub33_backup_$(date +%Y%m%d).tar.gz oclub33/
Backup Supabase
Use Supabase Dashboard → SQL Editor → “Download Table Data”
or via CLI:

bash
Copy code
npx supabase db dump -f backup.sql
Restore
Extract from backup:

bash
Copy code
tar xzf oclub33_backup_YYYYMMDD.tar.gz -C /home/fla/REP/
🔐 5. Security Maintenance
Task	Recommendation
Rotate Gemini API Key	Every 90 days
Rotate Supabase Keys	Every 6 months
Check .env permissions	Monthly
Apache SSL renewal	Auto-renew via certbot
Verify CGI permissions	After updates
Update Ubuntu packages	Monthly (sudo apt update && sudo apt upgrade)

🧩 6. Supabase Table Verification
Check schema consistency monthly:

sql
Copy code
select table_name from information_schema.tables
where table_schema='public';
Ensure these tables exist:

nginx
Copy code
people
organization_units
person_roles
iterations
app_data
surveys
🧠 7. Common Problems & Fixes
Symptom	Likely Cause	Fix
Missing .env file	Wrong path or permissions	chmod 711 /home/fla & chmod 640 .env
Cannot POST /cgi-bin/gemini-proxy.sh	CGI not enabled	sudo a2enmod cgid & restart
Loading active iteration... hangs	Supabase query returns null	Check iterations table
No Gemini output	Bad API key or network	Regenerate key & retry curl test
No CSV/JSON data	Wrong /data/ path	Confirm /data in DocumentRoot

🧰 8. Update Workflow
When modifying HTML or data files:

bash
Copy code
cd ~/REP/oclub33
git pull
nano file.html
git add .
git commit -m "Update layout or logic"
git push fflajs main
If you need to roll back:

bash
Copy code
git checkout static-v1
🧾 9. Version Control Checklist
File	Purpose
VERSION.txt	Version ID + build date
README.md	General overview
CHANGELOG.md	Update history
DEPLOY.md	Server setup & deployment
DOCS.md	Developer reference
SUMMARY.md	System overview
MAINTENANCE.md	This file (system admin)

🧭 10. Future Migration Plan (Optional)
Target	Benefit
Supabase Edge Function	Replace CGI script, modernize Gemini integration
Vercel / GitHub Pages	Host static frontend only
Docker Container	Single packaged deployment for easy migration
Tailwind Build CLI	Optimized CSS for production
Offline Backup Sync	Schedule with cron and rclone

🧩 Example Cron Job for Backups
bash
Copy code
crontab -e
Add this line:

bash
Copy code
0 3 * * 0 tar czf /home/fla/backups/oclub33_$(date +\%Y\%m\%d).tar.gz /home/fla/REP/oclub33
✅ Maintenance Summary
Area	Action	Frequency
Apache logs	Check	Weekly
Supabase connection	Verify	Weekly
Backups	Archive	Weekly
Gemini proxy	Test	Monthly
SSL certificate	Auto-renew	Ongoing
Security patches	Apply	Monthly
Version push to GitHub	Commit/tag	As needed

System: Apache + CGI + Supabase
Version: Cognos v3 – Static Supabase Edition
Maintained by: Flavio (Vienna)
Last Updated: 2025-10-14
