{ lib, ... }:
{
  networking = {
    hostName = "vega";
    useNetworkd = true;
    firewall = {
      allowedTCPPorts = [
        80
        443
      ];
      allowedUDPPorts = [ 443 ];
    };
    usePredictableInterfaceNames = false;
  };

  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = "eth0";
      dhcpV4Config = {
        UseDNS = false;
      };
      dns = [
        "1.1.1.1#one.one.one.one"
        "1.0.0.1#one.one.one.one"
        "2606:4700:4700::1111#one.one.one.one"
        "2606:4700:4700::1001#one.one.one.one"
      ];
      networkConfig.DHCP = "ipv4";
      address = [ "2a01:4f8:c013:91ba::1/64" ];
      routes = [
        {
          Gateway = "fe80::1";
        }
      ];
      linkConfig.RequiredForOnline = "routable";
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "opportunistic";
      DNSSEC = "false";
      Domains = [ "~." ];
      FallbackDNS = [ "9.9.9.9#dns.quad9.net" ];
    };
  };
}
