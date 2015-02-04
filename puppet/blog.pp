
# Class: apache
#
#
class apache {
	package { 'apache2':
		ensure => installed,
	}

	service { 'apache2':
		enable      => true,
		ensure      => running,
		require    => Package["apache2"],
	}
}

# Class: php
#
#
class php {
	package { 'php5':
		ensure => installed,
	}
}

# Class: mysql
#
#
class mysql {
	
	package { 'mysql-server':
		ensure => installed,
	}
	service { 'mysql':
		enable      => true,
		ensure      => running,
		require     => Package['mysql-server']
	}
}


# Class: wordpress
#
#
class wordpress {

	Exec {
		path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:'
	}

	exec { 'apt-update':
		command      => '/usr/bin/apt-get update',
	}

	package { 'wget':
		ensure => installed,
	}

	exec { 'download-wordpress':
		command		=> 'wget https://wordpress.org/latest.tar.gz',
		creates 	=>  '/tmp/latest.tar.gz',
		cwd			=> '/tmp',
		require => Package['wget']
	}

	exec { 'unzip-wordpress':
		command     => 'tar -xzf /tmp/latest.tar.gz',
		cwd			=> '/var/www/html',
		creates		=> '/var/www/html/wordpress',
		require		=> Exec['download-wordpress']
	}

	exec { 'create-wordpress-db':
		command      => 'mysql -u root -p -e \'CREATE DATABASE wordpress;\'',
		unless		 => 'mysql -u root -e \'use wordpress\'',
		require => Service['mysql']
	}
}

# Class: blog_profile
#
#
class blog_profile {
	include apache
	include php
	include mysql
	include wordpress
}

include blog_profile