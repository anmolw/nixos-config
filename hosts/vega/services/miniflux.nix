{ config, pkgs, ... }:
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.sops.secrets.miniflux-admin-credentials.path;
    config = { };
  };

  sops.secrets."miniflux-admin-credentials" = {
    owner = "miniflux";
  };

  users.users.miniflux = {
    isSystemUser = true;
    group = "miniflux";
  };
  users.groups.miniflux = { };

  services.caddy.virtualHosts = {
    "miniflux.anmolw.com" = {
      extraConfig = ''
        reverse_proxy :8080
      '';
    };
  };
}
