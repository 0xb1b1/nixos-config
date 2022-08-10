{ config, pkgs, ... }:

{
  imports =  [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Use the systemd-boot EFI bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
  };

  # Setup keyfile
  boot.initrd = {
    secrets = {
      "/crypto_keyfile.bin" = null;
    };
    kernelModules = [ "amdgpu" ];
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-bfe69e52-7676-4bcd-8c5a-0a5dcd247146".device = "/dev/disk/by-uuid/bfe69e52-7676-4bcd-8c5a-0a5dcd247146";
  boot.initrd.luks.devices."luks-bfe69e52-7676-4bcd-8c5a-0a5dcd247146".keyFile = "/crypto_keyfile.bin";

  # Fix touchpad.
  services.xserver.libinput.enable = true;
  #services.xserver.synaptics.enable = true;  # https://www.reddit.com/r/NixOS/comments/cbi1tm/comment/etfmr9r/  #! Doesn't work

  networking = {
    hostName = "outline";
    interfaces = {
      wlp2s0.useDHCP = true;
    };
    # Configure network proxy if necessary.
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Define additional users.
  # users.users = {
  #   arina = {
  #     isNormalUser = true;
  #     description = "arina";
  #     shell = pkgs.bash;
  #     hashedPassword = "$6$cQWJCPMwSqsbh9r$mIALQWkszxd8W4lHHq9JLkJIOLzRnfre9RVBFoidi1zssk9rvPZEAvtRCMqc5tTkq95ZfOLIcLomAzbXkvX7F1";
  #   };
  # };

  # List packages installed per-machine in system profile. To search, run:
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
