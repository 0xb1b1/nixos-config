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
      };
      volumes = [
        "/var/podman/compose/heimdall/config:/config"
        "/etc/localtime:/etc/localtime:ro"
      ];
    };
  };
}
