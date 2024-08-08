#!/bin/bash
cd /var/log/windows
# Állítsuk be a változókat
LOG_FILE="192.168.88.2.log"
BACKUP_DIR="/var/log/windows/backup"
DATE=$(date +"%Y-%m-%d")
YESTERDAY=$(date -d "yesterday" '+%Y-%m-%d')
ARCHIVE_FILE="$BACKUP_DIR/$YESTERDAY.tar.xz"

# Ellenőrizzük, hogy a backup könyvtár létezik-e, ha nem, hozzuk létre
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Tömörítjük a log fájlt
tar -cJf "$ARCHIVE_FILE" "$LOG_FILE"

# Ürítsük ki az eredeti log fájlt
echo $DATE > "$LOG_FILE"

# Töröljük a két hétnél régebbi tömörített fájlokat
find "$BACKUP_DIR" -type f -name "*.tar.xz" -mtime +14 -exec rm {} \;

# Végeztünk
echo "Log fájl sikeresen tömörítve és a régi backupok törölve."
