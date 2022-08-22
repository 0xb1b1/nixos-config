{ config, pkgs, modulesPath, ... }:

{
  imports =  [
    ./hardware-configuration.nix
    ./modules
  ];

  # Import secrets
  #sops.defaultSopsFile = ./secrets.yaml;
  #sops.age.keyFile = "/home/voxel/.config/sops/age/keys.txt";  #! TODO: Change .this path

  #! Test secrets
  #sops.secrets.example_key = {};

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Use the systemd-boot EFI bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
  };

  # Configure networking.
  networking = {
    hostName = "shadow-nix";
    interfaces = {
      eno1.useDHCP = true;
    };
    # Configure DNS.
    networkmanager.insertNameservers = [ "127.0.0.1" ];  # PiHole
    # Configure network proxy if necessary.
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # List packages installed per-machine in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = with pkgs; [  ]

  # Open ports in the firewall.
  # [ Syncthing, Podman (PiHole), NGINX, NGINX, Dev, Dev, Podman (Gitea SSH), Podman (rustdesk),
  # Podman (rustdesk), Podman (rustdesk), Podman (rustdesk), Podman (rustdesk), Podman (Veloren), Podman (Veloren), Docker Swarm, Docker Swarm, Docker Swarm, Podman/NGinx (PiHole DOT) ]
  networking.firewall.allowedTCPPorts = [ 22000 53 80 443 8000 8080 23410 21115 21116 21117 21118 21119 14004 14005 2376 2377 7946 853 ];
  # [ Syncthing, Syncthing, Podman (PiHole), Podman (rustdesk), Docker Swarm, Docker Swarm, Podman/NGinx (PiHole DOT) ]
  networking.firewall.allowedUDPPorts = [ 22000 21027 53 21116 7946 4789 853 ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
}
