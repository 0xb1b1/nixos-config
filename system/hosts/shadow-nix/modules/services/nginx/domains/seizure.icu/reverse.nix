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
      #locations."/".proxyPass = "http://127.0.0.1:23417";
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
    "solarvoxel.seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23500";
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
    "jitsi.seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23424";
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
    "mmath.seizure.icu" = {
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
      locations."/".proxyPass = "http://127.0.0.1:23550";
    };
    "vashina.seizure.icu" = {
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
        proxyPass = "http://127.0.0.1:1515";
        proxyWebsockets = true;
      };
      extraConfig = ''
        proxy_set_header X-Script-Name /pgadmin4;
        proxy_redirect off;
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
  };
}
