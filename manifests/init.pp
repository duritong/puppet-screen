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
        file {'screen_root_configfile':
                path => '/root/.screenrc',
                owner => root,
                group => 0,
                mode => 600,
                source => "puppet://$server/screen/screenrc/root",
        }
}

