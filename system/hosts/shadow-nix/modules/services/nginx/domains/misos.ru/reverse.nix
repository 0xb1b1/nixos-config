{
  services.nginx.virtualHosts = {
    "misos.ru" = {
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
      forceSSL = false;
      #sslCertificate = "/var/nginx/certs/seizure.icu/fullchain.pem";
      #sslCertificateKey = "/var/nginx/certs/seizure.icu/privkey.pem";
      locations."/".proxyPass = "http://127.0.0.1:23445";
      locations."/.well-known/" = {};
    };
  };
}
