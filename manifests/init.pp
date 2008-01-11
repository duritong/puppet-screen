# modules/screen/manifests/init.pp - manage screen stuff
# Copyright (C) 2007 admin@immerda.ch
#

#modules_dir { "screen": }

class screen {
        package { 'screen':
                ensure => present,
                category => $operatingsystem ? {
                        gentoo => 'app-misc',
                        default => '',
                },
		source => $operatingsystem ? {
			openbsd => 'ftp://mirror.switch.ch/pub/OpenBSD/4.2/packages/i386/screen-4.0.3p0.tgz',
			default => undef,
		},
        }
}

define screen::deploy_screenrc(
	$source = 'normal',
	$target = '/root/.screenrc',
	$uid	= 'root',
	$gid	= '0' ){
	
	file {$name:
                path => $target,
                owner => $uid,
                group => $gid,
                mode => 600,
                source => "puppet://$server/screen/${source}",
        }
}

