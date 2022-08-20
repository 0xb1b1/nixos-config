{
  # Enable Podman.
  virtualisation.podman = {
    enable = true;
    #dockerCompat = true;
    defaultNetwork = {
      dnsname.enable = true;
    };
    #dockerSocket.enable = true;
  };
}
