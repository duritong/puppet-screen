# modules/screen/manifests/init.pp - manage screen stuff
# Copyright (C) 2007 admin@immerda.ch
#

modules_dir { "screen": }

class screen {
        package { 'screen':
                ensure => present,
                category => $operatingsystem ? {
                        gentoo => 'app-misc',
                        default => '',
                },
        }

	screen::deploy_screenrc{screenrc_root:}
}

define screen::deploy_screenrc(
	$source = 'normal',
	$target = '/root/.screenrc',
	$uid	= 'root',
	$gid	= '0' ){
	
	file {'screen_root_configfile':
                path => $target
                owner => $uid,
                group => $gid,
                mode => 600,
                source => "puppet://$server/screen/${source}",
        }
}

