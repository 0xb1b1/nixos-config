{
  services.nginx.virtualHosts = {
    "seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23447";
      root = "/var/http/seizure.icu";
      locations."/.well-known/" = {};
    };
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
      locations = {
        #"/web/".proxyPass = "http://127.0.0.1:23402/web/index.html";
        "/" = {
          proxyPass = "http://127.0.0.1:23402";
          proxyWebsockets = true;  # Thanks to https://git.alarsyo.net/alarsyo/nixos-config/commit/49a261e5ee97e8a91546600e57756eeef93b2472?style=split&whitespace=
        };
      };
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
    "drone.seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23422";
    };
    "nextcloud.seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23400";
    };
    "home.seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23429";
    };
    "status.seizure.icu" = {
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
      locations."/" = {
        proxyPass = "http://127.0.0.1:23418";
        proxyWebsockets = true;
      };
    };
    "pihole.seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23411";
    };
    "desktop.seizure.icu" = {
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
      locations."/guacamole/" = {
        proxyPass = "http://127.0.0.1:23430/guacamole/";
        proxyWebsockets = true;
      };
      extraConfig = ''
        proxy_buffering off;
      '';
    };
    "datacats.seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23432";
    };
    "meowsis.seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23435";
    };
    "photos.seizure.icu" = {  # PhotoPrism
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
      locations."/" = {
        proxyPass = "http://127.0.0.1:23437";
        proxyWebsockets = true;
      };
    };
    "english.seizure.icu" = {  # English
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
      locations."/" = {
        proxyPass = "http://127.0.0.1:23501";
        proxyWebsockets = true;
      };
    };
    "target.seizure.icu" = {
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
      locations."/" = {
        proxyPass = "http://127.0.0.1:23650";
        proxyWebsockets = true;
      };
    };
    "vidar.target.seizure.icu" = {
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
      sslCertificate = "/var/nginx/certs/target.seizure.icu/fullchain.pem";
      sslCertificateKey = "/var/nginx/certs/target.seizure.icu/privkey.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:23651";
        proxyWebsockets = true;
      };
    };
    "httpshare.seizure.icu" = {
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
      locations."/" = {
        proxyPass = "http://127.0.0.1:23438";
        proxyWebsockets = true;
      };
    };
    "photos-father.seizure.icu" = {  # PhotoPrism (Father)
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
      locations."/" = {
        proxyPass = "http://127.0.0.1:23443";
        proxyWebsockets = true;
      };
    };
    "warden.seizure.icu" = {
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
      locations."/" = {
        proxyPass = "http://127.0.0.1:23406";
        proxyWebsockets = true;
      };
    };
    "vault.seizure.icu" = {
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
      locations."/" = {
        proxyPass = "http://127.0.0.1:23444";
        proxyWebsockets = true;
      };
    };
    "transmission.seizure.icu" = {
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
      locations."/" = {
        proxyPass = "http://127.0.0.1:23446";
        proxyWebsockets = true;
      };
    };
    "hass.seizure.icu" = {
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
      extraConfig = ''
        proxy_buffering off;
      '';
      locations."/" = {
        proxyPass = "http://10.0.0.3:8123";
        proxyWebsockets = true;
      };
    };
    "ctf1.seizure.icu" = {
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
      extraConfig = ''
        proxy_buffering off;
      '';
      locations."/" = {
        proxyPass = "http://127.0.0.1:5076";
        proxyWebsockets = true;
      };
    };
    "penpot.seizure.icu" = {
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
      extraConfig = ''
        proxy_buffering off;
      '';
      locations."/" = {
        proxyPass = "http://127.0.0.1:23448";
        proxyWebsockets = true;
      };
    };
  };
}
