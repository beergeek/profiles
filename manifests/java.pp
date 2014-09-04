class profiles::java {


  file { 'java_file':
    ensure => present,
    path   => 'C:\\data\jre-8u5-windows-x64.exe',
    owner  => 'Administrator',
    group  => 'Administrators',
    mode   => '0755',
    source => "puppet:///modules/profiles/jre-8u5-windows-x64.exe",
  }

  package { 'Java 8 Update 5 (64-bit)':
    ensure          => present,
    source          => 'C:\data\jre-8u5-windows-x64.exe',
    install_options => ['/s',{'WEB_JAVA' => 0}, '/L','C:\crap.log'],
    require         => File['java_file'],
  }

  windows_path { 'add_java':
    ensure    => present,
    directory => 'C:\Program Files\Java\jre8\bin',
    require   => Package['Java 8 Update 5 (64-bit)'],
  }

  reboot { 'Java Path':
    subscribe => Windows_path['add_java'],
    apply     => immediately,
  }

}
