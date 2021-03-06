#!/bin/bash

#Hosts
db=db-b.foo.org.nz
mgmt=mgmt-b.foo.org.nz
backupvm=backup-b.foo.org.nz
app=app-b.foo.org.nz
host=$(hostname)
if [ $host == $mgmt ]
then
BDIR="
/etc/node-exporter
/etc/nagios
/etc/nagios3
/etc/nagios-plugins
/etc/puppet/code
/etc/puppet/puppet.conf
"
# the name of the backup machine
BSERVER=groupb
USERX=restore-b.foo.org.nz
BACKUPDIR=`date +%d-%m-%Y-%H-%M-%S`
OPTS="-haAXuv -v --progress --log-file=/home/bitstudent/rsync.log --backup-dir=~/backup/mgmt/backup-$BACKUPDIR" 

for d in $BDIR;do
rsync $OPTS $d $BSERVER@$USERX:~/backup/mgmt
done
#=====================================================================================================
elif [ $host == $db ]
then
echo " db vm"
BUDIR="
/etc/node-exporter
/etc/nagios
/etc/nagios-plugins
/etc/mysql
/etc/puppet
/etc/backup/mysql-backup
"
sudo chmod o+rx /etc/mysql/debian.cnf

# MYSQL BACKUP
MYSQLDATE=`date +%d%m%Y%H%M%S`
cd /etc/backup/mysql-backup
sudo mysqldump  --skip-extended-insert --all-databases --add-drop-table > sqlbackup.sql
sudo chown bitstudent -R /etc/backup/mysql-backup
sudo chgrp  bitstudent -R /etc/backup/mysql-backup 
sudo chmod 770 -R /etc/backup/mysql-backup

# the name of the backup machine
BSERVER=groupb
USERX=restore-b.foo.org.nz
DBBACKUPDIR=`date +%d-%m-%Y-%H-%M-%S`
OPTS="-haAXuv -v --progress --log-file=/home/bitstudent/rsync.log --backup-dir=~/backup/db/backup-$DBBACKUPDIR"

for d in $BUDIR;do
rsync $OPTS $d $BSERVER@$USERX:~/backup/db/
done
sudo chmod o-rx /etc/mysql/debian.cnf
#==========================================================================
elif [ $host == $app ]
then
echo " app vm"

BDIR="
/etc/apache2
/var/www/owncloud/data
"
sudo chmod o+rx /var/www/owncloud/data -R
# excludes file - this contains a wildcard pattern per line of files to exclude
# the name of the backup machine
BSERVER=groupb
USERX=restore-b.foo.org.nz
BACKUPDIR=`date +%d-%m-%Y-%H-%M-%S`
OPTS="-haAXuv -v --exclude --log-file=/home/bitstudent/rsync.log --backup-dir=~/backup/app/backup-$BACKUPDIR"

for d in $BDIR;do
rsync $OPTS $d $BSERVER@$USERX:~/backup/app
done

sudo chmod o-rx /var/www/owncloud/data -R

#====================================================
else [ $host == $backupvm ]
echo "backup vm"

BDIRBU="
/etc/node-exporter
/etc/nagios
/etc/nagios-plugins
/etc/puppet
/etc/prometheus-plugins
/etc/prometheus/prometheus
/etc/prometheus/prometheus.yml
/etc/prometheus/rules.yml
/etc/prometheus/tsdb
/etc/prometheus/promtool
/etc/prometheus/consoles
/etc/prometheus/console_libraries
/etc/prometheus/NOTICE
/etc/prometheus/queries.active
"
# the name of the backup machine
BSERVER=groupb
USERX=restore-b.foo.org.nz
BACKUPDIR=`date +%d-%m-%Y-%H-%M-%S`
OPTS="-haAXuv -v --exclude --log-file=/home/bitstudent/rsync.log --backup-dir=~/backup/backup/backup-$BACKUPDIR"

for d in $BDIRBU;do
rsync $OPTS $d $BSERVER@$USERX:~/backup/backup
done
fi
