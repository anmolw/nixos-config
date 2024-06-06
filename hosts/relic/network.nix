{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.hostName = "relic"; # Define your hostname.
  networking.interfaces.eno1.ipv4.addresses = [
    {
      address = "192.168.29.120";
      prefixLength = 24;
    }
  ];
  networking.nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
  networking.defaultGateway = {
    address = "192.168.29.1";
    interface = "eno1";
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    dnsovertls = "true";
  };

  networking.firewall.allowedTCPPorts = [
    8096 # jellyfin
  ];

  networking.firewall.allowedUDPPorts = [
    1900 # jellyfin
    7359 # jellyfin
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [8096 445 2049];
  # networking.firewall.allowedUDPPorts = [8096];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
