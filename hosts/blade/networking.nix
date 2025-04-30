{
  networking = {
    hostName = "blade"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    networkmanager.dns = "systemd-resolved";
    firewall.allowedTCPPorts = [
      57621 # spotify
    ];
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
