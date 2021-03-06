class nrpe::config {

file { '/etc/nagios/nrpe.cfg':
        ensure => present,
        group => 'nagios',
	source => 'puppet:///modules/nrpe/nrpe.cfg',
        mode => '0777',
}

nagios_hostgroup {"disk-servers":
        target => "/etc/nagios3/conf.d/ppt_hostgroups.cfg",
        mode => "0777",
        alias => 'My remote disk servers',
        members => 'backup-b.foo.org.nz,db-b.foo.org.nz,app-b.foo.org.nz',
        }

nagios_hostgroup {"hosts-alive":
        target => "/etc/nagios3/conf.d/ppt_hostgroups.cfg",
        mode => "0777",
        alias => 'My hosts servers',
        members => 'backup-b.foo.org.nz,db-b.foo.org.nz,app-b.foo.org.nz',
        }


}


