class profiles::base {

  #$sysctl_settings = hiera('profiles::base::sysctl_settings')
  ##$sysctl_defaults = hiera('profiles::base::sysctl_defaults')

  #create_resources(sysctl,$sysctl_settings, $sysctl_defaults)

  if $::osfamily != 'windows' {
    class {'ntp':
      servers => ['192.168.61.1'],
    }
  } else {
    class {'winntp':
      ntp_servers => ['192.168.61.1'],
    }
  }

}
