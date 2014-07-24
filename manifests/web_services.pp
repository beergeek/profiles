class profiles::web_services {

  $website_hash 	= hiera_hash('profiles::web_services::website_hash')
  $website_defaults 	= hiera('profiles::web_services::website_defaults')
  $host_hash		= hiera_hash('profiles::web_services::host_hash')
  $host_defaults	= hiera('profiles::web_services::host_defaults')

  #build base web server
  require apache
  require apache::mod::php
  require apache::mod::ssl

  #create web sites
  create_resources('apache::vhost',$website_hash,$website_defaults)

  #create host entries
  create_resources('host',$host_hash,$host_defaults)

  # add firewall rules
  firewall { '100 allow http and https access':
    port   => [80, 443],
    proto  => tcp,
    action => accept,
  }

}
