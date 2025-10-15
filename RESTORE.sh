#!/bin/bash
# ============================================================
#  RESTORE SCRIPT for Club33 Cognitive Web App (Cognos v3)
#  Author: Flavio (Vienna)
#  Version: 1.0 (interactive restore)
#  Created: 2025-10-14
#
#  Description:
#    - Lists available backup archives in /home/fla/backups/
#    - Lets you select which one to restore
#    - Extracts to /home/fla/REP/oclub33_restored_<timestamp>
#    - Prompts before overwriting any existing directory
# ============================================================

BACKUP_DIR="/home/fla/backups"
RESTORE_BASE="/home/fla/REP"
LOG_FILE="${BACKUP_DIR}/restore.log"

# ---- Header ----
echo "--------------------------------------------"
echo "Club33 RESTORE Utility"
echo "Started at: $(date)"
echo "--------------------------------------------"
echo

# ---- Check backup directory ----
if [ ! -d "$BACKUP_DIR" ]; then
  echo "❌ Backup directory not found: $BACKUP_DIR"
  exit 1
fi

cd "$BACKUP_DIR" || exit

# ---- List backups ----
echo "Available backups:"
echo "--------------------------------------------"
BACKUPS=(oclub33_backup_*.tar.gz)

if [ ${#BACKUPS[@]} -eq 0 ]; then
  echo "No backup files found in $BACKUP_DIR"
  exit 1
fi

# Display numbered list
select FILE in "${BACKUPS[@]}"; do
  if [ -n "$FILE" ]; then
    echo "You selected: $FILE"
    break
  else
    echo "Invalid selection. Please try again."
  fi
done

# ---- Define restore target ----
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
RESTORE_DIR="${RESTORE_BASE}/oclub33_restored_${TIMESTAMP}"

# ---- Confirm extraction ----
echo
echo "Restore target: $RESTORE_DIR"
read -p "Proceed with extraction? (y/N): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "❌ Restore cancelled."
  exit 0
fi

# ---- Extract backup ----
mkdir -p "$RESTORE_DIR"
tar -xzf "$FILE" -C "$RESTORE_BASE" 2>>"$LOG_FILE"

RC=$?
if [ $RC -eq 0 ]; then
  echo "✅ Successfully restored: $FILE → $RESTORE_DIR"
  echo "Restore completed at $(date)" >> "$LOG_FILE"
else
  echo "❌ Restore failed (rc=$RC)"
  echo "Failure restoring $FILE at $(date)" >> "$LOG_FILE"
fi

echo
echo "--------------------------------------------"
echo "Done."

