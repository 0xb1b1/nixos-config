{ config, pkgs, ... }:

{
  imports =  [
    ./hardware-configuration.nix
    ./modules
  ];

  # Fix touchpad.
  services.xserver.libinput.enable = true;

  # Configure networking.
  networking = {
    hostName = "outline";
    interfaces = {
      wlp2s0.useDHCP = true;
    };
    # Configure DNS.
    networkmanager.insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
    # Configure network proxy if necessary.
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Enable blueman.
  services.blueman.enable = true;

  # List packages installed per-host in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = with pkgs; [  ]

  # Open ports in the firewall.
  # [ Syncthing ]
  networking.firewall.allowedTCPPorts = [ 22000 ];
  # [ Syncthing, Syncthing ]
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
}
