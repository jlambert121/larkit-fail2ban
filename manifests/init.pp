# = Class: fail2ban
#
# This is the main fail2ban class
#
#
# == Parameters
#
#
class fail2ban (
  $version    = $::fail2ban::params::version,
  $config_dir = $::fail2ban::params::config_dir,
  $log_level  = $::fail2ban::params::log_level,
  $ignoreip   = $::fail2ban::params::ignoreip,
  $bantime    = $::fail2ban::params::bantime,
  $findtime   = $::fail2ban::params::findtime,
  $maxretry   = $::fail2ban::params::maxretry,
  $backend    = $::fail2ban::params::backend,
  $banaction  = $::fail2ban::params::banaction,
) inherits fail2ban::params {

  validate_absolute_path($config_dir)
  validate_re($log_level, ['^CRITICAL$', '^ERROR$', '^WARNING$', '^NOTICE$', '^INFO$', '^DEBUG$'])
  validate_re($backend, ['^pyinotify$', '^gamin$', '^polling$', '^systemd$', '^auto$'])
  validate_integer($maxretry)
  validate_integer($findtime)
  validate_integer($bantime)

  class { '::fail2ban::install': } ->
  class { '::fail2ban::config': } ~>
  class { '::fail2ban::service': }
  Class['Fail2ban::Install'] ~> Class['Fail2ban::Service']

}
