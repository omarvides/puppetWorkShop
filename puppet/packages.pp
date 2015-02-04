#modulo: colleccion de recursos minimos para una tecnologia

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

	#file { '/var/www/html/index.html':
    #	ensure => file,
	#	content => template('/vagrant/templates/index.html')
	#}
}

# Class: git
#
#
class git {
	package { 'git-core':
		ensure => installed,
	}

	$gitconfig = '
		[user]
		name =  Omar Vides
		email = omarvides@gmail.com'

	file { '/home/vagrant/.gitconfig':
		ensure => file,
		owner => vagrant,
		group => vagrant,
		content => $gitconfig,
		require => Package['git-core']
	}

}

include apache
include git