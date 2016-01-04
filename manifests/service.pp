# == Class fail2ban::service
#
# Manages the fail2ban service
#
class fail2ban::service {

  service { 'fail2ban':
    ensure => running,
    enable => true,
  }

}
