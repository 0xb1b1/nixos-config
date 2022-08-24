{
  imports = [
    ./nixos
    ./users
    ./containers
    ./display
    ./security
    ./sound
    ./games
  ];

  # Enable AppArmor.
  security.apparmor.enable = true;
}
