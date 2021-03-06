class mariadb::config {
    file { '/etc/mysql/mariadb.conf.d/50-server.cnf':
      ensure => present,
      source => 'puppet:///modules/mariadb/50-server.cnf',
      mode => '0444',
      owner => 'root',
      group => 'root',
      require => Class['mariadb::install'],
      notify => Class['mariadb::service'],
	}
#	exec { 'create-owncloud-db': 
#		command => 'sudo mysql --user=root --password=P@ssw0rd -e "Create database if not exists owncloud;"',
#		provider => 'shell',
#	}
}
