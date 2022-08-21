{
  services.nginx = {
    streamConfig = ''
      upstream pihole-dot {
        zone dns 64k;
        server 127.0.0.1:53;
      }
      server {
          listen 853 ssl;
          ssl_certificate /var/nginx/certs/seizure.icu/fullchain.pem;
          ssl_certificate_key /var/nginx/certs/seizure.icu/privkey.pem;
          proxy_pass pihole-dot;
      }
    '';
  };
}