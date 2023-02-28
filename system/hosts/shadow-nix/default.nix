{ config, pkgs, modulesPath, ... }:

{
  imports =  [
    ./hardware-configuration.nix
    ./modules
  ];

  # Import secrets
  #sops.defaultSopsFile = ./secrets.yaml;
  #sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  #! Test secrets
  #sops.secrets.example_key = {};

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

  # List packages installed per-host in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = with pkgs; [  ]

  # Open ports in the firewall.
  # TODO: Is it possible to open ports in different places @ the same time?
  networking.firewall.allowedTCPPorts = [ 2222   # EndleSSH
                                          22000  # Syncthing
                                          #53     # Podman (PiHole)
                                          80     # [Docker] Traefik
                                          443    # [Docker] Traefik
                                          8000   # Dev
                                          8080   # Dev
                                          23410  # [Docker] Gitea SSH
                                          14004  # [Docker] Veloren
                                          14005  # [Docker] Veloren
                                          3389   # xRDP
                                          #25402
                                          #23433
                                          #23435
                                          51413  # [Docker] Transmission TCP
                                          8581   # [Docker] Homebridge
                                          5353   # [Docker] Homebridge mDNS
                                          51827
                                          8123   # Home Assistant
                                          19999  # [Docker] Netdata
                                          65443
                                          65480
                                          25550  # Minecraft Spigot server: 0xb1b1-server
                                        ];
  # [ Syncthing, Syncthing, Podman (PiHole), Podman (rustdesk), Docker Swarm, Docker Swarm, Podman/NGinx (PiHole DOT) ]
  networking.firewall.allowedUDPPorts = [ 2222   # EndleSSH
                                          22000
                                          21027
                                          #53     # [Docker] PiHole
                                          #853    # [Docker] PiHole DOT
                                          51413  # [Docker] Transmission UDP
                                          5353   # [Docker] Homebridge mDNS
                                          51820  # [Docker] Wireguard
                                        ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # Enable VSCode Server daemon.
  services.vscode-server.enable = true;
}
