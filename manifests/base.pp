class profiles::base {

  $sysctl_settings = hiera('profiles::base::sysctl_settings')
  $sysctl_defaults = hiera('profiles::base::sysctl_defaults')

  class { 'firewall': }
  class {['profiles::fw::pre','profiles::fw::post']:}

  Firewall {
    require => undef,
    before  => Class['profiles::fw::post'],
    require => Class['profiles::fw::pre'],
  }

  create_resources(sysctl,$sysctl_settings, $sysctl_defaults)

  # setup NTP client
  include profiles::ntp_client

  # setup SSH server and firewall
  class { 'ssh::server':
      storeconfigs_enabled => false,
      options              => {
        'PermitRootLogin'  => 'yes',
        'Port'             => [22],
      },
  }
  firewall { '104 allow http ssh access':
    port   => [22],
    proto  => tcp,
    action => accept,
  }
}
