# manifests/screen.pp

class screen::selinux {
    case $operatingsystem {
        gentoo: { include screen::selinux::gentoo }
        default: { info("No selinux stuff yet defined for your distro") }
    }
}

class screen::selinux::gentoo {
    package{selinux-screen:
        ensure => present,
        category => 'sec-policy',
        require => Package[screen],
    }

    selinux::loadmodule {"screen": require => Package[selinux-screen] }
}
