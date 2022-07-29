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
  # TODO: Change luks-abcdefgh-1bcd-a2cd-ab3d-123456abcdef to a viable UUID
  boot.initrd.luks.devices."luks-abcdefgh-1bcd-a2cd-ab3d-123456abcdef".device = "/dev/disk/by-uuid/luks-abcdefgh-1bcd-a2cd-ab3d-123456abcdef";
  boot.initrd.luks.devices."luks-abcdefgh-1bcd-a2cd-ab3d-123456abcdef".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # TODO: Define your hostname.
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
  time.timeZone = "Europe/Berlin";  # TODO: Define your TZ

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

  ## Enable SELinux. (https://nixos.wiki/wiki/Workgroup:SELinux)
  #boot.kernelPatches = [ {
  #  name = "selinux-config";
  #  patch = null;
  #  extraConfig = 
  #    SECURITY_SELINUX y
  #    SECURITY_SELINUX_BOOTPARAM n
  #    SECURITY_SELINUX_DISABLE n
  #    SECURITY_SELINUX_DEVELOP y
  #    SECURITY_SELINUX_AVC_STATS y
  #    SECURITY_SELINUX_CHECKREQPROT_VALUE 0
  #    DEFAULT_SECURITY_SELINUX n
  #  ;
  #} ];
  #systemd.package = pkgs.systemd.override { withSelinux = true; };
  #boot.kernelParams = [ "security=selinux" ];
  #environment.systemPackages = with pkgs; [ policycoreutils ];

  # User settings.
  users.mutableUsers = true;
  boot.kernelParams = [ "nohibernate" ];

  # Configure keymap in X11.
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable the X11 windowing system and XFCE.
  #services.xserver = {
  #  enable = true;
  #  desktopManager = {
  #    xterm.enable = false;
  #    xfce.enable = true;
  #  };
  #displayManager.defaultSession = "xfce";
  #};

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
    voxel = {  # TODO: Set your username
      isNormalUser = true;
      description = "voxel";  # TODO: Enter a description or just your username
      extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      shell = pkgs.zsh;
    };
  };

  # Configure sudo.
  security.sudo.enable = false;
  #security.sudo.extraRules = [
  #  {
  #    users = [ "voxel" ];
  #    commands = [
  #      {
  #       command = "ALL";
  #       options = [ "NOPASSWD" ];
  #      }
  #    ];
  #  }
  #];

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

  # Set up Nginx as a reverse proxy.
  services.nginx = {
    enable = true;
    # Use recommended settings.
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    # Only allow PFS-enabled ciphers with AES256
    sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";
    
    commonHttpConfig = ''
      # Add HSTS header with preloading to HTTPS requests.
      # Adding this header to HTTP requests is discouraged
      map $scheme $hsts_header {
          https   "max-age=31536000; includeSubdomains; preload";
      }
      add_header Strict-Transport-Security $hsts_header;

      # Enable CSP for your services.
      #add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;

      # Minimize information leaked to other domains
      add_header 'Referrer-Policy' 'origin-when-cross-origin';

      # Disable embedding as a frame
      add_header X-Frame-Options DENY;

      # Prevent injection of code in other mime types (XSS Attacks)
      add_header X-Content-Type-Options nosniff;

      # Enable XSS protection of the browser.
      # May be unnecessary when CSP is configured properly (see above)
      add_header X-XSS-Protection "1; mode=block";

      # This might create errors
      proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
    '';

    virtualHosts = {
      "foo.bar.fqdn" = {
        listen = [
	  {
	    addr = "0.0.0.0";
	    port = 443;
	    ssl = true;
	  }
	  {
	    addr = "0.0.0.0";
	    port = 80;
	  }
	];
        forceSSL = true;
	sslCertificate = "/var/nginx/certs/foo/fullchain.pem";
	sslCertificateKey = "/var/nginx/certs/foo/privkey.pem";
        locations."/".proxyPass = "http://127.0.0.1:1234";
      };
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22000 53 80 443 8000 8080 ];  # Syncthing, Docker PiHole, NGINX, NGINX, Dev, Dev, 
  networking.firewall.allowedUDPPorts = [ 22000 21027 53 ];  # Syncthing, Syncthing, Docker PiHole, 
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
