$dir_moi = '/tmp/moi'

file{$dir_moi:
    ensure  => directory,
    owner   => 'ubuntu',
    recurse => true,
}

file{'/tmp/moi/otro-dir':
    ensure => directory
} 

file{'/tmp/moi/adios-mundo':
    ensure  => file,
    require => File['/tmp/moi']
}

$usuario = 'Omar'
$holamundo = "Hola ${usuario}!!!
${::fqdn}
${::ipaddress}
${::hostname}
${::osfamily}"


$holamundo_file = 'hola-mundo'
$holamundo_path = "/tmp/moi/${holamundo_file}"

file{$holamundo_path:
    ensure => file,
    owner  => 'ubuntu',
    content => $holamundo,
    require => File['/tmp/moi']
}

file{'/tmp/hola-mundo': 
    ensure => file,
    owner => 'vagrant'
}

file{'/tmp/moi/hola-link':
    ensure => link,
    target => '/tmp/moi/hola-mundo'
}