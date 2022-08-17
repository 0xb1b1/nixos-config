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

  # Configure Bluetooth sound via PipeWire.
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

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
