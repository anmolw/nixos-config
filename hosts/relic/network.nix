{
  networking.hostName = "relic"; # Define your hostname.
  networking.interfaces.eno1.ipv4.addresses = [
    {
      address = "192.168.29.120";
      prefixLength = 24;
    }
  ];
  networking.nameservers = [
    "1.1.1.1#one.one.one.one"
    "1.0.0.1#one.one.one.one"
  ];
  networking.defaultGateway = {
    address = "192.168.29.1";
    interface = "eno1";
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

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
  ];

  networking.firewall.allowedUDPPorts = [
  ];
}
