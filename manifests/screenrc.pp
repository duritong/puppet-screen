define screen::screenrc(
  $source = 'normal',
  $target = '/root/.screenrc',
  $owner  = 'root',
  $group  = '0'
){
  require ::screen
  file {$name:
    path => $target,
    source =>   [
      "puppet:///modules/site_screen/${::fqdn}/${source}",
      "puppet:///modules/site_screen/${source}",
      "puppet:///modules/screen/${source}"
    ],
    owner => $owner, group => $group, mode => 0600;
  }
}
