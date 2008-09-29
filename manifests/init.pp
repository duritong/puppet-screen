#
# screen module
#
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

#modules_dir { "screen": }

class screen {
    case $operatingsystem {
        gentoo: { include screen::gentoo }
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

define screen::deploy_screenrc(
	$source = 'normal',
	$target = '/root/.screenrc',
	$owner	= 'root',
	$group	= '0' ){
	
	file {$name:
                path => $target,
                source => "puppet://$server/screen/${source}",
                owner => $owner, group => $group, mode => 0600;
        }
}
