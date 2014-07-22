class profiles::database_services {

  $db_hash     = hiera_hash('profiles::database_services::db_hash')
  $db_defaults = hiera('profiles::database_services::db_defaults')

  require mysql::server
  class {'mysql::bindings':
    php_enable => true,
  }

  # create databases
  create_resources('mysql::db',$db_hash,$db_defaults)

} 
