🧠 Club33 Backup Guide (BACKUP.md)
📄 Overview

This script (BACKUP.sh) performs automated daily backups of the entire
Club33 static Supabase + CGI web application located at:

/home/fla/REP/oclub33


The backup system creates compressed archives, rotates old ones, and can send email alerts if something fails.

⚙️ 1. Backup script summary

File: /home/fla/REP/oclub33/BACKUP.sh
Version: 1.2 (email on failure + size report)
Author: Flavio (Vienna)
Tested on: Ubuntu 22.04 / 24.04

Features

Archives entire app directory including .env and /data

Saves .tar.gz backups to /home/fla/backups/

Logs to /home/fla/backups/backup.log

Keeps only the 5 most recent backups

Sends email alert via msmtp if backup fails

Works manually or with cron

📦 2. Backup contents
oclub33/
├── .env
├── data/
├── public/
├── *.html
├── *.sh
├── README.md / DEPLOY.md / SUMMARY.md
└── cgi-bin scripts


Example: oclub33_backup_2025-10-14_03-00-01.tar.gz

🧪 3. Manual run
cd ~/REP/oclub33
./BACKUP.sh


Logs: /home/fla/backups/backup.log
View: tail -n 20 /home/fla/backups/backup.log

📧 4. Email alert setup

Uses msmtp + mailutils.
Edit ~/.msmtprc with your Gmail app password.
If backup fails, an alert email is sent automatically.

⏰ 5. Automate with cron
crontab -e
0 3 * * * /home/fla/REP/oclub33/BACKUP.sh

🔁 6. Restore manually
cd /home/fla
tar -xzf /home/fla/backups/oclub33_backup_YYYY-MM-DD_HH-MM-SS.tar.gz

🔍 7. Logs & troubleshooting
tail -n 20 /home/fla/backups/backup.log
sudo tail -n 20 /var/log/msmtp.log
echo "Backup test" | mail -s "Club33 backup test" fflajs@gmail.com

🧹 8. Rotation

Only latest 5 archives are kept automatically.

🧭 9. Best practices

Ensure /home/fla/backups/ is writable

chmod +x BACKUP.sh after editing

Store a copy of .env off-site

Run a manual test weekly

🧰 10. Restore Helper Script (RESTORE.sh)

A simple interactive tool to extract any backup safely.

File: /home/fla/REP/oclub33/RESTORE.sh
Version: 1.0 (interactive restore)

✅ Features

Lists all available backups in /home/fla/backups/

Prompts to select which one to restore

Extracts into /home/fla/REP/oclub33_restored_<timestamp>

Never overwrites your live installation

Logs actions to /home/fla/backups/restore.log

🧩 Usage
chmod +x ~/REP/oclub33/RESTORE.sh
~/REP/oclub33/RESTORE.sh

🖥 Example
Available backups:
1) oclub33_backup_2025-10-14_03-00-01.tar.gz
#? 1
Restore target: /home/fla/REP/oclub33_restored_2025-10-14_15-35-22
Proceed? (y/N): y
✅ Successfully restored → /home/fla/REP/oclub33_restored_2025-10-14_15-35-22
