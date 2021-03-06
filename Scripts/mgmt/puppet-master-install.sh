#!/bin/bash

## When testing this in docker it failed because fresh install OS
## cannot do much without running an update first.
sudo apt-get update
## Then run followup installs
sudo apt-get install puppetmaster -y



LINE=certname=mgmt-b.foo.org.nz
LINE2=server=mgmt-b.foo.org.nz
FILE=/etc/puppet/puppet.conf

if
grep -qF "$LINE" "$FILE"; then
echo "already exists"
else
sudo sed -i "/^\[master]/a $LINE" "$FILE"
echo "done"
fi


if
grep -qF "$LINE2" "$FILE"; then
echo "already exists"
else
sudo sed -i "/^\[main]/a $LINE2" "$FILE"
echo "done"
fi

dir=/etc/puppet/code/environments/production/manifests/
mkdir -p $dir && touch $dir/site.pp

sudo systemctl restart puppetmaster




