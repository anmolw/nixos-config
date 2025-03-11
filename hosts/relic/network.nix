{
  networking = {
    hostName = "relic";
    useDHCP = false;
    dhcpcd.enable = false;
    firewall.allowedTCPPorts = [ ];
    firewall.allowedUDPPorts = [
      5353 # mDNS
    ];
  };

  systemd.network = {
    enable = true;
    networks."10-lan" = {
      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
        DNSOverTLS = true;
        MulticastDNS = true;
      };
      dhcpV4Config = {
        UseDNS = false;
      };
      dhcpV6Config = {
        UseDNS = false;
      };
      ipv6AcceptRAConfig = {
        UseDNS = false;
      };
      dns = [
        "1.1.1.1#one.one.one.one"
        "1.0.0.1#one.one.one.one"
        "2606:4700:4700::1111#one.one.one.one"
        "2606:4700:4700::1001#one.one.one.one"
      ];
      matchConfig.Name = "eno1";
      linkConfig.RequiredForOnline = "routable";
    };
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
