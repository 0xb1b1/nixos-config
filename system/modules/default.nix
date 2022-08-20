{
  imports = [
    ./users
    ./containers
    ./display
    ./security
    ./sound
  ];

  # Enable AppArmor.
  security.apparmor.enable = true;
}
