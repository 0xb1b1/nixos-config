# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-bfe69e52-7676-4bcd-8c5a-0a5dcd247146".device = "/dev/disk/by-uuid/bfe69e52-7676-4bcd-8c5a-0a5dcd247146";
  boot.initrd.luks.devices."luks-bfe69e52-7676-4bcd-8c5a-0a5dcd247146".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "outline"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Configure networking.
  networking.networkmanager = {
    enable = true;
    insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  ### SECURITY ###
  # Enable AppArmor.
  security.apparmor.enable = true;
  ### SECURITY ###

  # Enable Docker.
  #virtualisation.docker.enable = true;

  # Enable Podman.
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork = {
      dnsname.enable = true;
    };
  };

  # Enable libvirt (KVM).
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # User settings.
  users.mutableUsers = true;
  boot.kernelParams = [ "nohibernate" ];

  # Configure keymap in X11.
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Fix touchpad
  services.xserver.libinput.enable = true;

  # Enable the X11 windowing system and awesomeWM.
  services.xserver = {
    enable = true;
    # Configure a display manager.
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+awesome";
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };

  # Enable PipeWire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    voxel = {
      isNormalUser = true;
      description = "voxel";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      shell = pkgs.zsh;
    };
    arina = {
      isNormalUser = true;
      description = "arina";
      shell = pkgs.bash;
    };
  };

  # Configure sudo.
  security.sudo.enable = true;
  security.sudo.extraRules = [
   {
     users = [ "voxel" ];
     commands = [
       {
        command = "ALL";
        options = [ "NOPASSWD" ];
       }
     ];
   }
  ];

  # Configure doas.
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = [ "voxel" ];
	noPass = true;
	keepEnv = true;
      }
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    neovim
    wget
    zsh
    lsof
    virt-manager
    podman-compose
    dnsname-cni
    minikube
    shadowsocks-rust
    openvpn
  ];

  # Add udev rules.
  services.udev.packages = [
    pkgs.trezor-udev-rules
  ];

  # Enable gcr on dbus for gnome pinentry.
  services.dbus.packages = [ pkgs.gcr ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  services.pcscd.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # Open ports in the firewall.

  # Syncthing
  networking.firewall.allowedTCPPorts = [ 22000 ];
  
  # Syncthing, Syncthing, 
  networking.firewall.allowedUDPPorts = [ 22000 21027 ]; 
  
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Install flakes
  nix = {
    # Enable Flakes.
    package = pkgs.nixFlakes;
    # Set extra options (substituting is equal to using cache instead of building packages).
    extraOptions = ''
    substitute = true
    experimental-features = nix-command flakes
    '';
  };

  # Add extra lines in /etc/hosts.
  networking.extraHosts = ''
    127.0.0.1 host0.local
    127.0.0.1 host1.local
    127.0.0.1 host2.local
    127.0.0.1 host3.local
    127.0.0.1 host4.local
  '';
}
