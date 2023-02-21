{
  # Enable Docker.
  virtualisation.docker = {
    enable = true;
    liveRestore = false;  # Not compatible with Docker Swarm
    daemon.settings."default-address-pools" = [
      {
        base = "172.80.0.0/16";
        size = 24;
      }
      {
        base = "172.81.0.0/16";
        size = 24;
      }
    ];
  };
}
