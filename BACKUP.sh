#!/bin/bash
# ============================================================
#  BACKUP SCRIPT for Club33 Cognitive Web App (Cognos v3)
#  Author: Flavio (Vienna)
#  Version: 1.1 (email on failure)
#  Created: 2025-10-14
#
#  Description:
#    - Archives /home/fla/REP/oclub33
#    - Includes .env, /data, and all HTML files
#    - Saves compressed backups to /home/fla/backups/
#    - Keeps only the 5 most recent backups
#    - Sends an email alert ONLY if backup fails (requires 'mail' command)
# ============================================================

set -o pipefail

# ---- Configuration ----
SOURCE_DIR="/home/fla/REP/oclub33"
BACKUP_DIR="/home/fla/backups"
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="${BACKUP_DIR}/oclub33_backup_${TIMESTAMP}.tar.gz"
LOG_FILE="${BACKUP_DIR}/backup.log"

# Email alert target (set your address here)
ALERT_EMAIL="${ALERT_EMAIL:-flavio@example.com}"   # change to your real email

# ---- Ensure backup folder exists ----
mkdir -p "$BACKUP_DIR"

# ---- Log header ----
{
  echo "--------------------------------------------"
  echo "Backup started at $(date)"
} >> "$LOG_FILE"

# ---- Perform backup ----
tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")" 2>> "$LOG_FILE"
RC=$?

if [ $RC -eq 0 ]; then
  echo "✅ Backup successful: $BACKUP_FILE" >> "$LOG_FILE"
else
  echo "❌ Backup FAILED (rc=$RC) at $(date)" >> "$LOG_FILE"

  # Attempt email alert if 'mail' is available and an email is configured
  if command -v mail >/dev/null 2>&1 && [ -n "$ALERT_EMAIL" ]; then
    {
      echo "Backup FAILED on $(hostname) at $(date)"
      echo
      echo "Source: $SOURCE_DIR"
      echo "Destination: $BACKUP_FILE"
      echo "Return code: $RC"
      echo
      echo "Last 50 log lines:"
      tail -n 50 "$LOG_FILE"
    } | mail -s "[ALERT] Club33 backup FAILURE on $(hostname)" "$ALERT_EMAIL"
    echo "📧 Failure email sent to $ALERT_EMAIL" >> "$LOG_FILE"
  else
    echo "ℹ️ Email alert not sent (install 'mailutils' and set ALERT_EMAIL)." >> "$LOG_FILE"
  fi

  exit $RC
fi

# ---- Remove old backups (keep last 5) ----
cd "$BACKUP_DIR" || exit
ls -t oclub33_backup_*.tar.gz | tail -n +6 | xargs -r rm --verbose >> "$LOG_FILE" 2>&1

# ---- Log footer ----
{
  echo "Cleanup complete. Backup finished at $(date)"
  echo "--------------------------------------------"
  echo
} >> "$LOG_FILE"

exit 0

