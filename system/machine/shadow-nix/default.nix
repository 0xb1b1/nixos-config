{ config, pkgs, ... }:

{
  imports =  [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.kernelModules = [ "amdgpu" ];
  };

  networking = {
    hostName = "shadow-nix";
    interfaces = {
      eno1.useDHCP = true;
    };
    # Configure network proxy if necessary.
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Define additional users.
  users.users = {
    arina = {
      isNormalUser = true;
      description = "arina";
      shell = pkgs.bash;
      hashedPassword = "$6$cQWJCPMwSqsbh9r$mIALQWkszxd8W4lHHq9JLkJIOLzRnfre9RVBFoidi1zssk9rvPZEAvtRCMqc5tTkq95ZfOLIcLomAzbXkvX7F1";
    };
  };

  # List packages installed per-machine in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = with pkgs; [  ]

  # Open ports in the firewall.
  # [ Syncthing, Podman (PiHole), NGINX, NGINX, Dev, Dev, Podman (Gitea SSH), Podman (rustdesk),
  # Podman (rustdesk), Podman (rustdesk), Podman (rustdesk), Podman (rustdesk), ]
  networking.firewall.allowedTCPPorts = [ 22000 53 80 443 8000 8080 23410 21115 21116 21117 21118 21119 ];
  # [ Syncthing, Syncthing, Podman (PiHole), Podman (rustdesk), ]
  networking.firewall.allowedUDPPorts = [ 22000 21027 53 21116 ];

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

    # Only allow PFS-enabled ciphers with AES256.
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
      "jellyfin.seizure.icu" = {
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
	sslCertificate = "/var/nginx/certs/seizure.icu/fullchain.pem";
	sslCertificateKey = "/var/nginx/certs/seizure.icu/privkey.pem";
        locations."/".proxyPass = "http://127.0.0.1:23402";
      };
      "synapse.seizure.icu" = {
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
        sslCertificate = "/var/nginx/certs/seizure.icu/fullchain.pem";
        sslCertificateKey = "/var/nginx/certs/seizure.icu/privkey.pem";
        locations."/".proxyPass = "http://127.0.0.1:23414";
      };
      "threema.seizure.icu" = {
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
        sslCertificate = "/var/nginx/certs/seizure.icu/fullchain.pem";
        sslCertificateKey = "/var/nginx/certs/seizure.icu/privkey.pem";
        locations."/".proxyPass = "http://127.0.0.1:23421";
      };
      "gitea.seizure.icu" = {
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
        sslCertificate = "/var/nginx/certs/seizure.icu/fullchain.pem";
        sslCertificateKey = "/var/nginx/certs/seizure.icu/privkey.pem";
        locations."/".proxyPass = "http://127.0.0.1:23409";
      };
    };
  };
}
