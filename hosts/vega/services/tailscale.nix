{
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--stateful-filtering=false"
      "--operator=anmol"
    ];
  };
}
