class phabricator::phd (
    $path
){
  Class['phabricator'] -> Class['phabricator::phd']

  file { ['/var/tmp/phd',
          '/var/tmp/phd/pid',
          '/var/tmp/phd/log']:
    ensure => directory,
    owner  => root,
    group  => root,
  }

  $phd_path = "${path}/phabricator/bin" # For phd.erb template
  notify { "phabricator phabdir is #{phabricator::phabdir}":}

  file { '/etc/init.d/phd':
    ensure  => present,
    mode    => 0755,
    content => template("phabricator/phd.erb"),
  }

  service { 'phd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => File['/etc/init.d/phd'],
  }
}
