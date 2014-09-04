class profiles::java {

  case $::architecture {
    'x64': {
      $java_pkg_title = 'Java 8 Update 5 (64-bit)'
      $java_pkg_src = 'jre-8u5-windows-x64.exe'
    }
    'i386': {
      $java_pkg_title = 'Java 8 Update 5'
      $java_pkg_src = 'jre-8u5-windows-i586.exe'
    }
    default: {
      fail("You are obviously using a real OS")
    }
  }


  file { "C:/data/${java_pkg_src}":
    ensure => present,
    owner  => 'Administrator',
    group  => 'Administrators',
    mode   => '0755',
    source => "puppet:///modules/profiles/{$java_pkg_src}",
  }

  package { $java_pkg_title:
    ensure          => present,
    source          => "C:\data\${java_pkg_src}",
    install_options => ['/s',{'WEB_JAVA' => 0}, '/L','C:\crap.log'],
    require         => File["C:/data/${java_pkg_src}"],
  }

  windows_path { 'add_java':
    ensure    => present,
    directory => 'C:\Program Files\Java\jre8\bin',
    require   => Package[$java_pkg_title],
  }

  reboot { 'Java Path':
    subscribe => Windows_path['add_java'],
    apply     => immediately,
  }

}
