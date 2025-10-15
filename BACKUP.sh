#!/bin/bash
# ============================================================
#  BACKUP SCRIPT for Club33 Cognitive Web App (Cognos v3)
#  Author: Flavio (Vienna)
#  Version: 1.2 (email on failure + size report)
#  Updated: 2025-10-14
# ============================================================

set -o pipefail

# ---- Configuration ----
SOURCE_DIR="/home/fla/REP/oclub33"
BACKUP_DIR="/home/fla/backups"
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="${BACKUP_DIR}/oclub33_backup_${TIMESTAMP}.tar.gz"
LOG_FILE="${BACKUP_DIR}/backup.log"

# Email alert target
ALERT_EMAIL="${ALERT_EMAIL:-fla4all@gmail.com}"

# ---- Ensure backup folder exists ----
mkdir -p "$BACKUP_DIR"

{
  echo "--------------------------------------------"
  echo "Backup started at $(date)"
  echo "Host: $(hostname)"
  echo "Source: $SOURCE_DIR"
} >> "$LOG_FILE"

# ---- Perform backup ----
tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")" 2>> "$LOG_FILE"
RC=$?

if [ $RC -eq 0 ]; then
  SIZE=$(du -sh "$BACKUP_FILE" | awk '{print $1}')
  echo "✅ Backup successful: $BACKUP_FILE ($SIZE)" >> "$LOG_FILE"
else
  echo "❌ Backup FAILED (rc=$RC) at $(date)" >> "$LOG_FILE"

  # Email alert if msmtp + mailutils are configured
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
    echo "ℹ️ Email alert not sent (mailutils/msmtp not configured)" >> "$LOG_FILE"
  fi

  exit $RC
fi

# ---- Remove old backups (keep last 5) ----
cd "$BACKUP_DIR" || exit
ls -t oclub33_backup_*.tar.gz | tail -n +6 | xargs -r rm --verbose >> "$LOG_FILE" 2>&1

{
  echo "Cleanup complete. Backup finished at $(date)"
  echo "--------------------------------------------"
  echo
} >> "$LOG_FILE"

exit 0

