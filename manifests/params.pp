# Class: fail2ban::params
#
# This class defines default parameters used by fail2ban
#
class fail2ban::params {

  $version    = 'present'
  $config_dir = '/etc/fail2ban'
  $log_level  = 'INFO'
  $ignoreip   = '127.0.0.0/8'  #space seperated list
  $bantime    = 600
  $findtime   = 600
  $maxretry   = 5
  $backend    = 'auto'
  $banaction  = 'iptables-multiport'

  case $::operatingsystem {
    'RedHat', 'CentOS': {}
    default: {
      fail("Unsupported operating system: ${::operatingsystem}")
    }
  }

}
