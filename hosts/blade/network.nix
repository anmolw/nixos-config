{
  networking.hostName = "blade"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.networkmanager.dns = "systemd-resolved";

  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
      "9.9.9.9#dns.quad9.net"
    ];
    domains = ["~."];
    dnssec = "true";
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("users") && action.id === "org.freedesktop.NetworkManager.settings.modify.system") {
        return polkit.Result.YES;
      }
    });
  '';

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    57621 # spotify
  ];

  networking.firewall.allowedUDPPorts = [
    5353 # spotify
  ];
}
