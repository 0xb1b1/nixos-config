{
  virtualisation.oci-containers.containers = {
    heimdall-app = {
      image = "docker.io/linuxserver/heimdall:latest";
      autoStart = true;
      ports = [
        "23429:80"
      ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "Europe/Moscow";
      };
      volumes = [
        "/var/podman/compose/heimdall/config:/config"
      ];
    };
  };
}
