{
  networking = {
    hostName = "pi4"; # Define your hostname.
    interfaces.eno1.useDHCP = true;
    nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
    defaultGateway = {
      address = "192.168.29.1";
      interface = "eno1";
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };
    firewall.allowedTCPPorts = [ ];
    firewall.allowedUDPPorts = [ ];
  };

  services.resolved = {
    enable = true;
    dnssec = true;
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
      "9.9.9.9#dns.quad9.net"
    ];
    dnsovertls = "opportunistic";
  };
}
