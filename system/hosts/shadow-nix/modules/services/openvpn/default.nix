#! TESTING ONLY - not working yet

let
  # generate via openvpn --genkey --secret /root/openvpn/voyagey.priv.key
  client-key = "/root/openvpn/voyagey.priv.key";
  domain = "ovpn.seizure.icu";
  vpn-dev = "tun0";
  port = 1194;
in {
  # sudo systemctl start nat
  networking.nat = {
    enable = true;
    externalInterface = "eno1";
    internalInterfaces  = [ vpn-dev ];
  };
  networking.firewall.trustedInterfaces = [ vpn-dev ];
  networking.firewall.allowedUDPPorts = [ port ];
  environment.systemPackages = [ pkgs.openvpn ]; # for key generation
  services.openvpn.servers.smartphone.config = ''
    dev ${vpn-dev}
    proto udp
    ifconfig 10.8.0.1 10.8.0.2
    secret ${client-key}
    port ${toString port}

    cipher AES-256-CBC
    auth-nocache

    comp-lzo
    keepalive 10 60
    ping-timer-rem
    persist-tun
    persist-key
  '';

  environment.etc."openvpn/smartphone-client.ovpn" = {
    text = ''
      dev tun
      remote "${domain}"
      ifconfig 10.8.0.2 10.8.0.1
      port ${toString port}
      redirect-gateway def1

      cipher AES-256-CBC
      auth-nocache

      comp-lzo
      keepalive 10 60
      resolv-retry infinite
      nobind
      persist-key
      persist-tun
      secret [inline]

    '';
    mode = "600";
  };
  system.activationScripts.openvpn-addkey = ''
    f="/etc/openvpn/smartphone-client.ovpn"
    if ! grep -q '<secret>' $f; then
      echo "appending secret key"
      echo "<secret>" >> $f
      cat ${client-key} >> $f
      echo "</secret>" >> $f
    fi
  '';
}
