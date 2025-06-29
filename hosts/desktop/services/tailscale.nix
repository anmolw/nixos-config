{
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--operator=anmol"
    ];
  };
}
