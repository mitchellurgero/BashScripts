#! /bin/bash
# Make the following DIR's:
# /temp
# /backups

## START CONFIG
TIMESTAMP=$(date +"%F")
BACKUP_DIR=/temp/My-Backup-$TIMESTAMP
MYSQL_USER="USERNAME"
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD="PASSWORD"
MYSQLDUMP=/usr/bin/mysqldump
DATABASE=DB_TO_BACKUP
## END CONFIG

mkdir -p "$BACKUP_DIR/mysql"
$MYSQLDUMP --force --opt --user=$MYSQL_USER -p=$MYSQL_PASSWORD $DATABASE | gzip > "$BACKUP_DIR/mysql/$DATABASE.gz"
mkdir -p "$BACKUP_DIR/web_dir"
SRCDIR=/var/www/
DESTDIR=$BACKUP_DIR/web_dir/
FILENAME=My-WWW-Backup-$TIMESTAMP.tgz
tar --create --gzip --file=$DESTDIR$FILENAME $SRCDIR
tar --create --gzip --file=/backups/My-Backup-$TIMESTAMP.tgz $BACKUP_DIR
rm -rf /temp/*
wait
echo "Backup of DB and Web Directory Complete!"