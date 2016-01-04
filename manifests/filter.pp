# Define: fail2ban::filter
#
# Configures a fail2ban filter
#
# [*includes*]
#   Hash.  key/value set of options to include in the [INCLUDES] section
#
# [*definition*]
#   Hash.  key/value set of options to include in the [Definition] section
#
# [*init*]
#   Hash.  key/value set of options to include in the [Init] section
#
define fail2ban::filter (
  $includes   = {},
  $definition = {},
  $init       = {},
) {

  include ::fail2ban

  # Template uses
  # $includes
  # $definition
  # $init
  file { "${::fail2ban::config_dir}/filter.d/${name}.local":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('fail2ban/filter.d.local.erb'),
    notify  => Class['Fail2ban::Service'],
  }
}
