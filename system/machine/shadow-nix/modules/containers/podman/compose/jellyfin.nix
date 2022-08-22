{
  virtualisation.oci-containers.containers = {
    jellyfin-app = {
      image = "docker.io/voxel/jellyfin:latest";
      autoStart = true;
      user = "1000:1000";
      ports = [
        "23402:8096"
      ];
      environment = {
      };
      volumes = [
        "/var/podman/compose/jellyfin/config:/config"
        "/var/podman/compose/jellyfin/cache:/cache"
        "/mnt/wd3tb-001/docker/mounts/jellyfin/media:/media"
      ];
      extraOptions = [
        "--group-add=989"
        "--device=/dev/dri/renderD128:/dev/dri/renderD128"
        "--device=/dev/dri/card0:/dev/dri/card0"
      ];
    };
  };
}
