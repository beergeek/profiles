class profiles::ntp_client {

  $ntp_servers = hiera('profiles::ntp_client::ntp_servers')

  if $::osfamily != 'windows' {
    class {'ntp':
      servers => $ntp_servers,
    }
  } else {
    class {'winntp':
      ntp_servers => $ntp_servers,
    }
  }
}
