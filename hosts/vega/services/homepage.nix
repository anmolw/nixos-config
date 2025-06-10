{ config, ... }:
{
  services.homepage-dashboard = {
    enable = true;
    listenPort = 8081;
    allowedHosts = "dash.anmolw.com";
    services = { };
    widgets = { };
    environmentFile = config.sops.homepage-secrets.path;
  };

  sops.secrets.homepage-secrets = { };

  services.caddy.virtualHosts = {
    "dash.anmolw.com" = {
      extraConfig = ''
        reverse_proxy :8081
      '';
    };
  };
}
