class screen::openbsd {
  case $operatingsystemrelease {
    '4.3': { openbsd::special_package{'screen-4.0.3p1': } }
    default: { openbsd::special_package{'screen-4.0.3p2': } }
  }
}
