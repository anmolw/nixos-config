{
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--operator=anmol"
    ];
    extraDaemonFlags = [
      "--no-logs-no-support"
    ];
  };
}
