{
  networking = {
    hostName = "relic";
    interfaces.eno1.useDHCP = true;
    nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
    firewall.allowedTCPPorts = [ ];
    firewall.allowedUDPPorts = [
      5353 # mDNS
    ];
  };

  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    dnssec = "true";
    domains = [ "~." ];
    extraConfig = ''
      MulticastDNS = "true"
    '';
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
      "9.9.9.9#dns.quad9.net"
    ];
  };
}
