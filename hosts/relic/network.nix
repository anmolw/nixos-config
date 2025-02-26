{
  networking = {
    hostName = "relic"; # Define your hostname.
    interfaces.eno1.useDHCP = true;
    nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
    firewall.allowedTCPPorts = [ ];
    firewall.allowedUDPPorts = [ ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
      "9.9.9.9#dns.quad9.net"
    ];
    dnsovertls = "opportunistic";
  };
}
