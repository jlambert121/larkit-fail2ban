# == Class fail2ban::config
#
# Global configuration for fail2ban
#
class fail2ban::config (
  $log_level = $::fail2ban::log_level,
  $ignoreip  = $::fail2ban::ignoreip,
  $bantime   = $::fail2ban::bantime,
  $findtime  = $::fail2ban::findtime,
  $maxretry  = $::fail2ban::maxretry,
  $backend   = $::fail2ban::backend,
  $banaction = $::fail2ban::banaction,
){

  # Template uses
  # $log_level
  file { "${::fail2ban::config_dir}/fail2ban.local":
    ensure  => 'file',
    mode    => '0444',
    owner   => 'root',
    group   => 'root',
    content => template('fail2ban/fail2ban.local.erb'),
  }

  # Template uses
  # $ignoreip
  # $bantime
  # $findtime
  # $maxretry
  # $backend
  # $banaction
  file { "${::fail2ban::config_dir}/jail.local":
    ensure  => file,
    mode    => '0444',
    owner   => 'root',
    group   => 'root',
    content => template('fail2ban/jail.local.erb'),
  }

}
