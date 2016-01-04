# Define: fail2ban::jail
#
# Configures a fail2ban jail
#
# [*enable*]
#   Boolean.  Whether or not the jail should be enabled
#   Default: true
#
# [*config*]
#   Hash.  K/V of options for the jail
#
define fail2ban::jail (
  $enable = true,
  $config = {},
) {

  include ::fail2ban

  # Template uses
  # $enable
  # $config
  file { "${::fail2ban::config_dir}/jail.d/${name}.local":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('fail2ban/jail.d.local.erb'),
    notify  => Class['Fail2ban::Service'],
  }
}
