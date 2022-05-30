#!/bin/bash

# pull down changes from the remote repo
history -w
cd ~/OE2-Group-Project
sudo chmod 774 ./.git
sudo chmod 774 .gitignore
cd .git/
sudo chown bitstudent FETCH_HEAD
sudo chgrp bitstudent FETCH_HEAD
sudo chown bitstudent ORIG_HEAD
sudo chgrp bitstudent ORIG_HEAD
sudo chmod 774 ./**
cd objects
sudo chgrp bitstudent ./**
sudo chown bitstudent ./**
cd ~/OE2-Group-Project
git pull
cd ~/

# backup and set permissions on files

sudo cp /etc/puppet/ -r ~/OE2-Group-Project/Mgmt-VM/ -r
sudo rm -r ~/OE2-Group-Project/Mgmt-VM/puppet/ssl
sudo cp /etc/puppet/code/environments/production/manifests/site.pp ~/OE2-Group-Project/Mgmt-VM/puppet/
sudo cp /etc/hosts ~/OE2-Group-Project/Mgmt-VM/hosts
sudo chmod go+r ~/OE2-Group-Project/Mgmt-VM/hosts
sudo cp /etc/nagios3 -r ~/OE2-Group-Project/Mgmt-VM/ -r
sudo cp /etc/php/7.2/cgi/php.ini ~/OE2-Group-Project/Mgmt-VM/php.ini
cat '' > ~/OE2-Group-Project/Mgmt-VM/bash_history.txt
sudo cp ~/.bash_history ~/OE2-Group-Project/Mgmt-VM/bash_history.txt
sudo chmod go+r ~/OE2-Group-Project/Mgmt-VM/bash_history.txt
sudo cp ~/.bashrc ~/OE2-Group-Project/Mgmt-VM/bashrc
sudo chmod go+r ~/OE2-Group-Project/Mgmt-VM/bashrc
sudo cp /etc/nagios ~/OE2-Group-Project/Mgmt-VM -r
sudo cp /etc/nagios-plugins ~/OE2-Group-Project/Mgmt-VM -r
sudo cp /etc/prometheus-plugins ~/OE2-Group-Project/Mgmt-VM/prometheus-plugins -r
sudo cp /etc/systemd/system/node-exporter.service ~/OE2-Group-Project/Mgmt-VM/prometheus-plugins/node-exporter.service
sudo cp /etc/rsyslog.d/50-default.conf ~/OE2-Group-Project/Mgmt-VM/Logs
sudo cp /var/log/cron.log ~/OE2-Group-Project/Mgmt-VM/Logs
sudo cp /var/log/user.log ~/OE2-Group-Project/Mgmt-VM/Logs
sudo cp ~/rsync.log ~/OE2-Group-Project/Mgmt-VM/Logs
sudo cp ~/daily.log ~/OE2-Group-Project/Mgmt-VM/Logs
sudo cp ~/weekly.log ~/OE2-Group-Project/Mgmt-VM/Logs
sudo chown -R bitstudent ~/OE2-Group-Project/Mgmt-VM
sudo chgrp -R bitstudent ~/OE2-Group-Project/Mgmt-VM
sudo chmod -R 775 ~/OE2-Group-Project/Scripts
cd ~/OE2-Group-Project

# check for file changes

if [ -z "$(git status --porcelain)" ]; then 
	# no changes to add to a commit
  cd ~/
else 
  COMMIT_TIMESTAMP=`date +'%d-%m-%Y %H:%M:%S %Z'`
  git add .
  git commit -m "mgmt: automated system backup" -m "completed: $COMMIT_TIMESTAMP" -m "mgmt-b"
  git push
  cd ~/
fi
