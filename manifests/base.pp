class profiles::base {

  $sysctl_settings = hiera('profiles::base::sysctl_settings')
  $sysctl_defaults = hiera('profiles::base::sysctl_defaults')

  create_resources(sysctl,$sysctl_settings, $sysctl_defaults)

  include profiles::ntp_client
}
