{
  networking = {
    hostName = "desktop";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
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
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
      "9.9.9.9#dns.quad9.net"
    ];
  };
}
