class profiles::apache_php {

  require apache
  require apache::mod::php
  require apache::mod::ssl

}
