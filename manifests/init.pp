# modules/screen/manifests/init.pp - manage screen stuff
# Copyright (C) 2007 admin@immerda.ch
#

#modules_dir { "screen": }

class screen {
    case $operatingsystem {
        gentoo: { include screen::gentoo }
        openbsd: { include screen::openbsd }
        default: { include screen::base }
    }
    screen::deploy_screenrc{ "root_screenrc": }

    if $selinux {
        include screen::selinux
    }
}
class screen::base {
    package { 'screen':
        ensure => present,
    }
}

class screen::gentoo inherits screen::base {
    Package[screen]{
        category => 'app-misc',
    }
}

class screen::openbsd inherits screen::base {
    Package[screen]{
        source => 'ftp://mirror.switch.ch/pub/OpenBSD/4.2/packages/i386/screen-4.0.3p0.tgz',
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

