# == Class fail2ban::install
#
# Installs fail2ban
#
class fail2ban::install {

  package { 'fail2ban':
    ensure => $fail2ban::version,
  }

  if $::fail2ban::backend == 'gamin' {
    package { 'gamin':
      ensure => 'present',
    }
  }

}
