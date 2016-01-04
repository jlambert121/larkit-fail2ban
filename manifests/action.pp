# Define: fail2ban::action
#
# Configures a fail2ban action
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
define fail2ban::action (
  $includes   = {},
  $definition = {},
  $init       = {},
) {

  include ::fail2ban

  # Template uses
  # $includes
  # $definition
  # $init
  file { "${::fail2ban::config_dir}/action.d/${name}.local":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('fail2ban/action.d.local.erb'),
    notify  => Class['Fail2ban::Service'],
  }
}
